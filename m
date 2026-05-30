Return-Path: <stable+bounces-256850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLXoAYY8GmqR2QgAu9opvQ
	(envelope-from <stable+bounces-256850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 03:25:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C1860AC1E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 03:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B0D1303EB89
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A81247DE1;
	Sat, 30 May 2026 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhzUCvdd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4E86334
	for <stable@vger.kernel.org>; Sat, 30 May 2026 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104227; cv=none; b=hgZZrqXSjHGDGOeiiN0m50L4ZlL3rXTNRgvpVYiIpwJuURKoGophGGvi7KlmIqX4CMVw+SA+rn3Yfk3t9oZ04ZETVNLm8etNq1gVjbYU2WSrsyUxbuw9udOCrBJt8JQPk6+51gB73vzD/rj5p7afDGIswLEAGxAOhRzg3qmenB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104227; c=relaxed/simple;
	bh=oLzxluydf0D+mC43ms/YNYpBohBD8+MXDAa2VQptkFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTSRh2kG0+XUSz3qsURu8i4sy+v1LJJ8FSG9kjgkC310qO0o+Ill0zqLVb2BIYMsrNH3V/69bZJRyRgfdhKLJ5hRkJwKeCQM5FlNZzX5SP1/c7dwsD6VoSV5A+cae9qBXjgOT5VJ6g+ikmuiB2X9YmJKucUNbedYfGZsbteF1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhzUCvdd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F951F00893;
	Sat, 30 May 2026 01:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780104226;
	bh=Ls0ERNa26M/LXcK61bMfEjpL+aWZl3dXjat5v1pwgCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KhzUCvddvWOHXfNEKtQPKv9/GbFKBihTuHtLHLluznh/krt6fV4tZSewC4RnHKmQO
	 onQa2elIqt5CnXJWdSGe5ySbmqNl3x0zTEvnLFRAMoRyBlkW4kP4l+DgmTYtZn+SfC
	 XBgyTHF4pzKPgxyg6rq98EGSkwtDM9U12zYNnBDe2QBQpUEODM0Pck3j9vFvZnzbX/
	 HqvxoT/AWfjBHsPLzpg7FBecqOpn1WHbYEE/tkg4RdYPdcrAFDrm5IiGiFDCQGDCeA
	 al+gcoHOD5B9gYGAJtffvJpAuka59lfzn2sa6A281ZEJ4cL+RMo12NruOZhlNZKGrK
	 bFTpnQirT1cCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ice: fix VF queue configuration with low MTU values
Date: Fri, 29 May 2026 21:23:43 -0400
Message-ID: <20260530012343.2600440-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052804-fringe-uncaring-cd63@gregkh>
References: <2026052804-fringe-uncaring-cd63@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256850-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,mpg.de:email,msgid.link:url]
X-Rspamd-Queue-Id: 73C1860AC1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

[ Upstream commit 3ba4dd024d26372733d1c02e13e076c6016e3320 ]

The ice driver's VF queue configuration validation rejects
databuffer_size values below 1024 bytes, which prevents VFs from
using MTU values below 871 bytes.

The iavf driver calculates databuffer_size based on the MTU using:
  databuffer_size = ALIGN(MTU + LIBETH_RX_LL_LEN, 128)

where LIBETH_RX_LL_LEN = 26 (ETH_HLEN + 2*VLAN_HLEN + ETH_FCS_LEN).

For MTU values below 871:
  MTU 870: 870 + 26 = 896, aligned to 128 = 896 (< 1024, rejected)
  MTU 871: 871 + 26 = 897, aligned to 128 = 1024 (>= 1024, accepted)

The 1024-byte minimum seems unnecessarily restrictive, because the hardware
supports databuffer_size as low as 128 bytes (the alignment boundary),
which should allow MTU values down to the standard minimum of 68 bytes.

I haven't found the reason why the limit was configured in the commit
9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message"), so
with no more information and since it is working, change the minimum
databuffer_size validation from 1024 to 128 bytes to allow standard low
MTU values while still preventing invalid configurations.

Fixes: 9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message")
cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20260515182419.1597859-3-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied the change to ice_virtchnl.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index fa9d928081d63..7cc04e7a9eef0 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1648,7 +1648,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 
 			if (qpi->rxq.databuffer_size != 0 &&
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
-			     qpi->rxq.databuffer_size < 1024))
+			     qpi->rxq.databuffer_size < 128))
 				goto error_param;
 			vsi->rx_buf_len = qpi->rxq.databuffer_size;
 			vsi->rx_rings[i]->rx_buf_len = vsi->rx_buf_len;
-- 
2.53.0


