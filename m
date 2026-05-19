Return-Path: <stable+bounces-249606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG3jHSlyDGpKhgUAu9opvQ
	(envelope-from <stable+bounces-249606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:22:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7457580718
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98F033105600
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC1F4028D9;
	Tue, 19 May 2026 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieUzg1jV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F833403F4;
	Tue, 19 May 2026 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200061; cv=none; b=dY8+mIDJL6mOA9b/nNLPUTFRhBaSU1NNG6QlY8sT1GlVSlFHf8x85s4zWxXilONg65xhwd6Bl21+DOizXlxLWyB/+joTZmhXIPukpXae2Nn/wEeGV04lG94tmornXm+qbfSWoys4MARp1L/U0WA59APXYgsqBD4Sb+6gnK9FqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200061; c=relaxed/simple;
	bh=UxyNgEu8F8lJ600LafBQhKRC7BR8d8IvR+LnJoYK0G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdS21VpyC3Isxf4KqPEYic4p3ceqhk2r0iAvbm9qKpKxewRmae/vBeeLF/cQ3HsyV9QqOylibPerPXmeqjm1eGY0kmBH/6oieUg/q+IdVRgRGnT6O8oePwhubLtqBJd21hetI/xmtiua2j+CDXge/guMDL964g95hzBg0j2P3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieUzg1jV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779200059; x=1810736059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UxyNgEu8F8lJ600LafBQhKRC7BR8d8IvR+LnJoYK0G0=;
  b=ieUzg1jVvGkc/5P39tfO7/+v22b4xdok1Mv3WmfS1+S3a1ekGR3JJdHU
   T/mP1RE/JNJyuwHMxLyCdZUjfeBrIX2mO1HkqPjMs/O51NMdnyfovRqS0
   danxs7EmeWgX4T6Hubashwith8wEK89vo4Y7msRTRCIq6R60F34wsBBz1
   by6p+Bp4dyMAzMntzvpQ9Cyh/1NWn0FuZ1pORvPIzgXCsynE+WRCD32Te
   kHagrFdW120fKVgn/NqysCyOMRhlXkaz9kEh9IdFMmq3l0442eiGDixqs
   v5dYqrWdzTCtIi+FTZrWSb8MgcKJ7Xf/OY3YssEf7pfUJ4lY0mYuAuPFM
   w==;
X-CSE-ConnectionGUID: WjrUYifHSTG35YRMu0Npsg==
X-CSE-MsgGUID: rBi3s7ZgRX+9MytVRDnWsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79929639"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79929639"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:14:19 -0700
X-CSE-ConnectionGUID: xlNnMbNzRSyweFPnT6/mnQ==
X-CSE-MsgGUID: 6wdeQIWqTl+BhN4tpP8MTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239836235"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 19 May 2026 07:14:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id AA75295; Tue, 19 May 2026 16:14:15 +0200 (CEST)
Date: Tue, 19 May 2026 17:14:03 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: ucsi: Check if power role change
 actually happened before handling
Message-ID: <agxwK43LRZytVxPK@kuha>
References: <20260519-ucsi-fix-2-v1-0-6f1239535187@qtmlabs.xyz>
 <20260519-ucsi-fix-2-v1-1-6f1239535187@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-ucsi-fix-2-v1-1-6f1239535187@qtmlabs.xyz>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249606-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chromium.org:url]
X-Rspamd-Queue-Id: B7457580718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 06:41:39PM +0700, Myrrh Periwinkle wrote:
> The CrOS EC may send a connector status change event with the power
> direction changed flag set even if the power direction hasn't actually
> changed after initiating a SET_PDR command internally [1]. In practice
> this happens on every system suspend due to other changes performed by
> the EC [2][3][4], causing suspend to fail.
> 
> Fix this by checking if the power role change actually happened before
> handling it.
> 
> [1]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=1689;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> [2]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=3923;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> [3]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=5094;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> [4]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=2229;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> 
> Cc: stable@vger.kernel.org
> Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
> Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 5b7ad9e99cb9..e19b656609e4 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1277,7 +1277,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  						  work);
>  	struct ucsi *ucsi = con->ucsi;
>  	u8 curr_scale, volt_scale;
> -	enum typec_role role;
> +	enum typec_role role, prev_role;
>  	u16 change;
>  	int ret;
>  	u32 val;
> @@ -1288,6 +1288,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  		dev_err_once(ucsi->dev, "%s entered without EVENT_PENDING\n",
>  			     __func__);
>  
> +	prev_role = UCSI_CONSTAT(con, PWR_DIR);
> +
>  	ret = ucsi_get_connector_status(con, true);
>  	if (ret) {
>  		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
> @@ -1304,7 +1306,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  	change = UCSI_CONSTAT(con, CHANGE);
>  	role = UCSI_CONSTAT(con, PWR_DIR);
>  
> -	if (change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
> +	if ((change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role) {
>  		typec_set_pwr_role(con->port, role);
>  		ucsi_port_psy_changed(con);
>  
> 
> -- 
> 2.54.0

-- 
heikki

