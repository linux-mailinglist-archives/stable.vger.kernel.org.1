Return-Path: <stable+bounces-247652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIj6Du78BmoeqgIAu9opvQ
	(envelope-from <stable+bounces-247652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:01:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1403654DF15
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6833231086AB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40123AC0E4;
	Fri, 15 May 2026 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="iIjdiexk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ri+b1213"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F03033E1
	for <stable@vger.kernel.org>; Fri, 15 May 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841055; cv=none; b=MNbTfO3IR1ItiH5iiHpjYYHUJ1vckr6FFRqdThdAonW3MqMp9Krfg6Tb8vs76XzHgHdHxCUJXF8jzxzhyCDJu1uxCQACDLZjYJmJHciFTYx1oW+cP3MVqOwu2d4L4FTtND0OKejjnq533++p9iDlKxJFdYtW+DvHLdPsddHzYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841055; c=relaxed/simple;
	bh=U3MR9U/zF81nffphZj13Vc5HRal0yX7ZT/1oDHJK3eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEou57SdUO9KaOxwSVXo4QsdQqFzd9JsBoznbF8xX6LwPtp6utuRXrvNOg3NUjFwBPO/VK3y8osBqnlKpvo9UFP8edsP4RXS5z6aE8quDGtSmSpbg2t3Cyx9SbiL1H8htJopFIG00Ohz+Jahyxw+g7IYVdwWVLBcsOgGTsIdgpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=iIjdiexk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ri+b1213; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EF46EC01AC;
	Fri, 15 May 2026 06:30:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 15 May 2026 06:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778841053; x=1778927453; bh=GD2M/WMAgN
	HLH2hjbnkqutnbwxQPJpegUKTom8KmYts=; b=iIjdiexkPpxg9S/xYHwKBltjoo
	HumaWYXLsWppPXaMoQRElxCQSDmD8+vseMNdwXhQN0O73Z/W70HWBrMWDcnc3aOl
	n+dcU4tLW2ya0VUtU6uJbjJ5C6ZfHNQJGEYfy5tEkxhIOjoDkhruKx8I9ivsuzEE
	CjrckprbmSeC4ioMMC1+Ohb21ul6n6QIUU+eUDaL4VUC7cBnWxjdg9hFOVpfxmA9
	fmieqZPuNoBlSiPbpTvCkNIpBPLcDW29yijfCUbQMXL51sOhFTVVc0NkF3CMeiBT
	tFmavZTpP3smgqPiU4Yo9tWPYlufqTthDkwU01PCcrhnRaX9v8GTLgpKe/cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778841053; x=1778927453; bh=GD2M/WMAgNHLH2hjbnkqutnbwxQPJpegUKT
	om8KmYts=; b=Ri+b1213bwn+3zoqoZNokgyxuhC57fA6tykifBNWsz6x9gxcIdo
	ruks+XW73jmDTjGDgM1APSZA2wdAokbW0Vg32qaU93OvA8XRp/nbDUpOiDfR9xmw
	DNL2iHIhGHDaJ90DRJLBCThoRtJIPIl8D5D+PGjQXSyVIAXhX3ToCMJ+beg9lmx/
	CI5GYc2b/PmnknZvjR1EWag6lSOCrKbpMjgxA4tJROIrDZS+YIPWyeynqFklq8UD
	hWw1jyV3tyQFSNxDgaA0e2XaDxGO5fBWqb4x46i9WiLkn347T0zGlh75zg2pzxxR
	KxVxQTEl4Q3C0t7z16Ts44xp14b/fx5O5Ng==
X-ME-Sender: <xms:3PUGauRWsVlBmSRJu0pAOA1H98nNgLNe_UbiOvgjD3hML8Yo5lTWVw>
    <xme:3PUGatFGsDqnJPw1qxqFPpK_7CLdR1jokVsNEHEcpWyrqgA1Yp9WAEmsLVrovM7T3
    zR70BGq69pKX0taRppbE0F7I9v4N61xNT025w_mIgdHYv-L>
X-ME-Received: <xmr:3PUGajG8z0nE_8LAjHWXZPXayxone4ewUP6NCb8wKv0aGy0YEYReWmIG8etPmpnuP-oiUwnLQJ5Mu3V3I0OR7sPBBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjeetueehte
    ekuefhleehkeffffeiffeftedtieegkedviefggfefueffkefgueffnecuffhomhgrihhn
    pehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehrrghfrggvlhdrjhdrfiihshhotghkihesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:3PUGarRF45oO586UhUhyHHykLejRE58gl4MCFGbPJ4ULWKt1iRF42A>
    <xmx:3PUGakLcXIuBg9wgAPikMnq8kPUoISL0Aqk-6wD4_3MZCAUf8EOvHw>
    <xmx:3PUGamYYEww1rjBTi7EOY8BAUg2YbFbMBd7mH3FXsAZGpXSNP-LOCg>
    <xmx:3PUGam_jWCnoZh2mcCdMXkO_emjB5oxGWVvPs4hINRZR77TrCTa9FQ>
    <xmx:3fUGaofEOIFrIxQIMNdGSiOHBzi-z59NuDW_Fjw5giTJi3N7RndJfLm9>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 06:30:52 -0400 (EDT)
Date: Fri, 15 May 2026 12:30:57 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 6.6.y] thermal: core: Free thermal zone ID later during
 removal
Message-ID: <2026051552-handcuff-immovably-7bf0@gregkh>
References: <2026051204-dazzling-those-ecf3@gregkh>
 <20260514192609.1258270-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514192609.1258270-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 1403654DF15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-247652-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 03:26:09PM -0400, Sasha Levin wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> [ Upstream commit daae9c18feec74566e023fc88cfb0ce26e39d868 ]
> 
> The thermal zone removal ordering is different from the thermal zone
> registration rollback path ordering and the former is arguably
> problematic because freeing a thermal zone ID prematurely may cause
> it to be used during the registration of another thermal zone which
> may fail as a result.
> 
> Prevent that from occurring by changing the thermal zone removal
> ordering to reflect the thermal zone registration rollback path
> ordering.
> 
> Also more the ida_destroy() call from thermal_zone_device_unregister()
> to thermal_release() for consistency.
> 
> Fixes: b31ef8285b19 ("thermal core: convert ID allocation to IDA")
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Link: https://patch.msgid.link/5063934.GXAFRqVoOG@rafael.j.wysocki
> [ Context ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/thermal/thermal_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 660a8d6f35673..f8f18c3ebdda4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -804,6 +804,7 @@ static void thermal_release(struct device *dev)
>  		     sizeof("thermal_zone") - 1)) {
>  		tz = to_thermal_zone(dev);
>  		thermal_zone_destroy_device_groups(tz);
> +		ida_destroy(&tz->ida);
>  		mutex_destroy(&tz->lock);
>  		complete(&tz->removal);
>  	} else if (!strncmp(dev_name(dev), "cooling_device",
> @@ -1481,8 +1482,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  	thermal_set_governor(tz, NULL);
>  
>  	thermal_remove_hwmon_sysfs(tz);
> -	ida_free(&thermal_tz_ida, tz->id);
> -	ida_destroy(&tz->ida);
>  
>  	device_del(&tz->device);
>  	put_device(&tz->device);
> @@ -1490,6 +1489,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  	thermal_notify_tz_delete(tz_id);
>  
>  	wait_for_completion(&tz->removal);
> +
> +	ida_free(&thermal_tz_ida, tz->id);
> +
>  	kfree(tz->tzp);
>  	kfree(tz);
>  }
> -- 
> 2.53.0
> 
> 

Does not apply at all :(

