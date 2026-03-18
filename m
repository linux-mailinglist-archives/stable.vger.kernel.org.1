Return-Path: <stable+bounces-226931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO6OJFLtuWm3PgIAu9opvQ
	(envelope-from <stable+bounces-226931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:09:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0792B4884
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 811983029764
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3A04A02;
	Wed, 18 Mar 2026 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SknrV58W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B3125B2
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792591; cv=none; b=htx3rUBzq5MvAEnQB0GzrLUBQONQCMwlup9zbAB5rt0aDT16psWoWpaoKM4Zl6K6xxP7zbHl0J2MRYK0ueEzihj1OgdEzfZqwi+WEPMQkcGdWc6b3EFe2tSgayjBF9AtcJrKDHn0qTFSnAzQTEzPEf9g01UNqSzSTDq4fV2Y2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792591; c=relaxed/simple;
	bh=y/ysLG715aKHx1kW+YG9A0anZYpBfXea2CGuKuIgXKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkss7wqH0bXMw1l/gWKdBnB0bUyr+H8W8Qdj/Z4ml3PDHeVGLlGrila3BQ5mzr/Nrp0ynzONUhabgo1ZFHwpgf8ZDTXSXsI+wgyPwftHNOPauLotKJQpoAr+N6oNWUYHa5wbX61kvIfVaUwbOSMB4jgu7xWViut9FHRixVIoZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SknrV58W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43EAC19425;
	Wed, 18 Mar 2026 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773792590;
	bh=y/ysLG715aKHx1kW+YG9A0anZYpBfXea2CGuKuIgXKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SknrV58WE+Ms7jJytp4e6d9hRDJLRjf+gCxwUGC8c0BvfKvqfQIySFBeDymyNSuZX
	 H1ypAV9hSJNj7I8tS5tOJJ7IzsMy50lHo5Q9KserKVojf59h+04Zn+IK4VgsUKi8xf
	 j8lGKB0bSWEgF/Fu4FXTDEeDrg+qbM8An1sWKXa38JgvEGbOPoV+VAiZokUzmzKw7L
	 S5hN7HG7Mbnr8oqqisfqV73KsNzx8AYQTSe58ULcIg1B1MB8LIJtt1KlkPRj76Tcc9
	 1SjUO1l8HCXmNqPnf4Kbihs/T136FgAapBy1SkoXSrhXGfTv1qg5IW1eaXixFubCvW
	 6ckKBevKP3OBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Simon Horman <simon.horman@corigine.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] ice: sleep, don't busy-wait, in the SQ send retry loop
Date: Tue, 17 Mar 2026 20:09:46 -0400
Message-ID: <20260318000947.379271-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318000947.379271-1-sashal@kernel.org>
References: <2026031701-reapprove-dollar-1839@gregkh>
 <20260318000947.379271-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226931-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,corigine.com:email,intel.com:email]
X-Rspamd-Queue-Id: 2C0792B4884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit b488ae52ef9f74155ab358f8c68e74327b45e0e1 ]

10 ms is a lot of time to spend busy-waiting. Sleeping is clearly
allowed here, because we have just returned from ice_sq_send_cmd(),
which takes a mutex.

On kernels with HZ=100, this msleep may be twice as long, but I don't
think it matters.
I did not actually observe any retries happening here.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: 326256c0a72d ("ice: reintroduce retry mechanism for indirect AQ")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 55a08fa1bf348..780c847cd1ffb 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1619,7 +1619,7 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 
 		memcpy(desc, &desc_cpy, sizeof(desc_cpy));
 
-		mdelay(ICE_SQ_SEND_DELAY_TIME_MS);
+		msleep(ICE_SQ_SEND_DELAY_TIME_MS);
 
 	} while (++idx < ICE_SQ_SEND_MAX_EXECUTE);
 
-- 
2.51.0


