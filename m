Return-Path: <stable+bounces-269621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dpkZEHf2QWrAxAkAu9opvQ
	(envelope-from <stable+bounces-269621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 06:37:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D126D5E04
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 06:37:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=K1xE2PRe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269621-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269621-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A85D3012C85
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 04:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1A6337107;
	Mon, 29 Jun 2026 04:37:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8711B86C7;
	Mon, 29 Jun 2026 04:37:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782707826; cv=none; b=p98nSP5vlDnNJqA2qdyLzPiLRjmkX5Cpo4WtXteLiXdpKjsoreXH/lo3qrdsO8KqB2zQ7Xw1TQG2/Fvpo1RT7SjTY6U0yz5hXCSxiNEon0TAwD/ulrbBNKi6McHkdinA8N5nlM7VF5ig4UCcZLcZ8PzrC53YSPKfMpaT1Guat38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782707826; c=relaxed/simple;
	bh=83+x3RkqgesZ3FFrecxekAZQqaAoQ+G7ED/qjYGvuT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2ygdJJddNjGp24m6Rq6sie2RxWdxduXYnxpVHcoyuJNXkk/xGw+LDRFHd/eotqw2yaWRs3A+BpTmWvzGNMLCBwPAKu/HM2Ci8uMSr6Cwr6UkJTmdNeHmJwvA0RhK2mHx/xNEE/CibMPKWXHx4A5pU18Dg/mKd3+a04Aeq4Bx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K1xE2PRe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CCA1F000E9;
	Mon, 29 Jun 2026 04:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782707825;
	bh=UA/8TEqnLRBtg+CS42jkaVku5zkA76i8pZuF/RPL1ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K1xE2PRee0tRW5Fj0/Pog1F+wyeWXqy7MTwYeWptzrT+TbYhTfIHi//3TmCWCX8HJ
	 SJqk7+HQ+bznYv7rNlG7xV//+CS0uFiUL5jfy2gyfanZk5WoCPtaVzeW0/zQy9Bkk9
	 otphbhj2ungjvDCfE6vmholxEKjaj+b49QjtVi7o=
Date: Mon, 29 Jun 2026 06:35:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kees@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	tomi.valkeinen@ideasonboard.com, mcanal@igalia.com,
	suraj.kandpal@intel.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/display: fix MST branch device refcount leak on
 DPCD write failure
Message-ID: <2026062906-bonding-pointless-f53d@gregkh>
References: <20260628133344.46188-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628133344.46188-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269621-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:kees@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:tomi.valkeinen@ideasonboard.com,m:mcanal@igalia.com,m:suraj.kandpal@intel.com,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,oss.qualcomm.com,ideasonboard.com,igalia.com,intel.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime,iscas.ac.cn:email,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94D126D5E04

On Sun, Jun 28, 2026 at 09:33:44PM +0800, WenTao Liang wrote:
> drm_dp_add_mst_branch_device initializes mstb with refcount 1, and
> drm_dp_mst_topology_get_mstb increments it to 2. When
> drm_dp_dpcd_write_byte fails, out_unlock performs only one
> drm_dp_mst_topology_put_mstb, leaving the other reference stored in
> mgr->mst_primary. Since MST was not successfully enabled, no disable path
> will clean it up.
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>

I did?  Where did I do that?

> Fixes: 7a3cbf590e63 ("drm/mst: Some style improvements in drm_dp_mst_topology_mgr_set_mst()")
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Again, you need to document the tools you used to find/fix this with
assisted-by, right?  Please read our documentation for when you use
LLMs.

thanks,

greg k-h

