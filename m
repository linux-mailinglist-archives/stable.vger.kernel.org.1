Return-Path: <stable+bounces-254802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONSJD2ASGGrKbggAu9opvQ
	(envelope-from <stable+bounces-254802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:01:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181845F01D4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71E713028F0D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D2C303A37;
	Thu, 28 May 2026 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGVIkuh7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B57E792
	for <stable@vger.kernel.org>; Thu, 28 May 2026 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962457; cv=none; b=B3qz7uu2mq4nDiN0TmltxhwMaJb9kxmtMWNfy0rabP0rAB9dy8RyB2uRLnZ+cFAecxudT0dluWPK29JyC36DjuF45eNTtXyMS3O/BVTppQyITnla762iso3gfLuWEB2hkyIG64/k9/w2EiXdxBHDZHHrOhxVsfkZtfuWFiV0jjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962457; c=relaxed/simple;
	bh=iLEudHtKwUsw8uPWJkfhUoCW8eEZft3i8vvgsnbfx4Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nUP5oyTU229f3HxqJ3jgXRpIisfg3VXJ74huhxZpgT9OY3LOY7rQqtr4UrqqjN9G8sMKaAYsPt83/ds1f2bbpchHpBv1bjVItmoZbcEFowstFmAvT06J4G7kdFWWTvugXK3C4lyJsq9pUx1yuVkOPKfduEbT43FJ6/5adcuZBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGVIkuh7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2B01F000E9;
	Thu, 28 May 2026 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779962455;
	bh=MLyLRsigN2xrbnAxNrz+Y/1ZkFP+Xj9tNysryyuTAts=;
	h=Subject:To:Cc:From:Date;
	b=dGVIkuh7B9XtuuHWWiX0Bpdnqf18L06TVHWBa0qHb8/RwePovVAJYEtpycAGyRZeI
	 Ix0lwOYj8Fy6V2giT9qF0SZ9Xl3dnT5RW7QbZlUdKgj3A8tsgiG+x8xSb9tmLjDdaX
	 FvOK0vNM55D9MmOi2xX6fQ1nSup3gczA2ed0+A8c=
Subject: FAILED: patch "[PATCH] ice: fix VF queue configuration with low MTU values" failed to apply to 6.12-stable tree
To: jtornosm@redhat.com,anthony.l.nguyen@intel.com,jacob.e.keller@intel.com,kuba@kernel.org,michal.swiatkowski@linux.intel.com,pmenzel@molgen.mpg.de,rafal.romanowski@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 12:00:02 +0200
Message-ID: <2026052802-enigmatic-canyon-c282@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254802-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[mpg.de:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[2026052802-enigmatic-canyon-c282.gregkh:query timed out,michal.swiatkowski.linux.intel.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,mpg.de:email,msgid.link:url,gregkh:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 181845F01D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3ba4dd024d26372733d1c02e13e076c6016e3320
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052802-enigmatic-canyon-c282@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ba4dd024d26372733d1c02e13e076c6016e3320 Mon Sep 17 00:00:00 2001
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Fri, 15 May 2026 11:24:09 -0700
Subject: [PATCH] ice: fix VF queue configuration with low MTU values

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

diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index f73d5a3e83d4..31be2f76181c 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -840,7 +840,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 
 			if (qpi->rxq.databuffer_size != 0 &&
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
-			     qpi->rxq.databuffer_size < 1024))
+			     qpi->rxq.databuffer_size < 128))
 				goto error_param;
 
 			ring->rx_buf_len = qpi->rxq.databuffer_size;


