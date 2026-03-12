Return-Path: <stable+bounces-224961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MJaKUses2mDSAAAu9opvQ
	(envelope-from <stable+bounces-224961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:12:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C9C278992
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 967853012BDB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7A401A06;
	Thu, 12 Mar 2026 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XmqDeHBb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E7346FB3;
	Thu, 12 Mar 2026 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346376; cv=none; b=ayboVd3yQX+O+uS7H/yxvlte7c8oC/Cnx6PcgA0KMvbGahcaz6QBfixldvz2eeen6Wiylm3IGJsnAqeFc9VQqjoqt7dUJ/lfaHk8aH0msTtciAMv0hB7ZG2Q43m7BEcDY0Hs2vSnDpL0CeaRGjPqAbNsZoYmi1+6n7HILJrSinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346376; c=relaxed/simple;
	bh=lEuAdZ10LDvQEj5laWRX7VDTIw8ad3Pkcdd59W8pTAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CO3U01Fb1Uy4r/NjS/RuFEejcsZkcjCqXcLWvO42UKZ9I4NkYCnyK3zWBcR2WlxUj0KJXvTpcCROYN3aLppVMrv9Iaeqf3JnHweZh+Kseh7PV2RZpSf9mt5tU+fE1AHJ+d7yxAxQNWB1qvfUq+Xe2J3KblQlS9u1UDpQr0hDGKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XmqDeHBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663C7C4CEF7;
	Thu, 12 Mar 2026 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346375;
	bh=lEuAdZ10LDvQEj5laWRX7VDTIw8ad3Pkcdd59W8pTAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XmqDeHBbJhyoGAz9WmYfT7Gxm+xU9oXrUMzKlv1jxy2t+N/5wQQIfBuM63AL3tonk
	 LVLaVeM3CXYVi8OgILgfy/rMGhdwbdZAMlhSEuiBArc57Mn987S4wTbMDATsTxslKW
	 L07C+oJyh53WIiEN3KIdfEX/rBBKvVRANNwnIa54=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Bart Van Assche <bvanassche@acm.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 028/265] drm/amdgpu: Unlock a mutex before destroying it
Date: Thu, 12 Mar 2026 21:06:55 +0100
Message-ID: <20260312201019.202372766@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224961-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,acm.org:email,amd.com:email,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: 40C9C278992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 5e0bcc7b88bcd081aaae6f481b10d9ab294fcb69 ]

Mutexes must be unlocked before these are destroyed. This has been detected
by the Clang thread-safety analyzer.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Fixes: f5e4cc8461c4 ("drm/amdgpu: implement RAS ACA driver framework")
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 270258ba320beb99648dceffb67e86ac76786e55)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index a7ecc33ddf223..ef5356b5a65ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -583,6 +583,7 @@ static void aca_error_fini(struct aca_error *aerr)
 		aca_bank_error_remove(aerr, bank_error);
 
 out_unlock:
+	mutex_unlock(&aerr->lock);
 	mutex_destroy(&aerr->lock);
 }
 
-- 
2.51.0




