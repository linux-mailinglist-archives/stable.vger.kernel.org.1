Return-Path: <stable+bounces-244541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BjEDF5f/Gm7OwAAu9opvQ
	(envelope-from <stable+bounces-244541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 11:46:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E54E636A
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 11:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 250C9309021F
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 09:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3027A372B48;
	Thu,  7 May 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf5P03eO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C03C3459
	for <stable@vger.kernel.org>; Thu,  7 May 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146872; cv=pass; b=odEZNlFH5angydd9XXAXHjwOuVaDjcedrAdCmDHr1ICZWGKBVx0jETeWabU1gmJVOEuTHb8egIS4feWNfhj6L7yE2fiLjRAMZ9KG2BIRMghg/NLot1EzCU9u1IV+WFFAk6W5bGX4ukENx25ZL70dtbsCPBjasiRZM0zvZXIZJCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146872; c=relaxed/simple;
	bh=hCxd+5uv4hdNBXidMCSMq1z3BpfTFZGcppb4STtJd00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMuGA6aQc5jfw9YhwF/ADi7PPYTA2HlDpEFQsUz0YVA4AX0lpFA/sgPO95Kag9MnyH+bc89ex2R8jwlGF9xg4qdIR7fZE7PEVjE6zXrTncLpN2zPYiIuFcpo5ZMi5eojF7vny7EanyJXxyp/O2Mk0RIEsYaRGBJpqXUHH5PAxvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf5P03eO; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c364b893aso616340d50.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 02:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778146870; cv=none;
        d=google.com; s=arc-20240605;
        b=GDJnz/V86ymV5FIBwudUYUJMf6IAhDlaK5lqQTJtPI9Ozu7RgbVtyzVnUwufwYpnXl
         FJvAeeu1xgyAm12UIKwi0Dc4TliqSCQ+FWDzLw8MRGHd8GO329sY51ykdmFz5YZC1RFy
         vYfnZKoajmw8V3/yCBBqJDpvgf1R8s+jzzkfuWiOLmzzIoZfwOY7OQ13qF2NYJ9Ns0Ex
         0Q+oiRXh8GCKpcZUeO2lScRyugje8l7spDGQClV23Er+dK49YBHmLXno0WUkcjJfncH3
         7G0WrqxbmTcJZBEfYnlNADMJ2iIHiZ48Kl5oojxzUdDgotuUQ+zAQbuyG53BiejJG1Pl
         pVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hCxd+5uv4hdNBXidMCSMq1z3BpfTFZGcppb4STtJd00=;
        fh=IHj19kGEzE179yB4Gw9VV9AHdwCjuDqRmeHK0PjqMVI=;
        b=R+z8by6RfPOMdC0Yu53HOnEKJrnh+/Q9pQVbW5YEYBdSkXzZc4QgXAhm6vXsz8Xu72
         94DM3AH75ql8J8mI2FiqQVUB0eIE/AGfaSqhfJMJid6IoMQ3qvj5sXYE3jZMtFuoodPZ
         p3MSlv9KCojU8OPXA9DeJrQh2L3kIfImrGCMYjcxLInqBsaskLRQoFTNTFJmWyWUTsCk
         wNbCe3K0Ce10wXFymlCx74E8sDlYLSfUFhHmrUYBoPiND6DtdXrrEbRWpInLHIqKPaeV
         IElhtSYaJ2ogIbFbktptjfBeDdq7AOFUz8VCYAEZIi4ycsTLqsNaS+hscocA75SpyKjH
         OL4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778146870; x=1778751670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hCxd+5uv4hdNBXidMCSMq1z3BpfTFZGcppb4STtJd00=;
        b=nf5P03eOTeu/x34Q61ogK87ioW/HORNCAdVtJzrid942OY9qGofjL1ykYGd7/YtjID
         hSI7SW+ABk+Tk6tsYOZbFrOB8kIjMjt53skqy2WnkzZt7jlCGwlLumIdcIXlIxs9umZt
         66cr/pjF6O6x/yOLFofjGI+g55XfJqrK1fw9W6FaCgBDSlcDD6Iazv4ETpYpG3eH2Y6z
         9NF8MXbFcHO52KyTCfeIUwpjn1IVBanouscKNQG51hkMSnViI9z1SUvQHLp5enKXkxNm
         HQpktmxqfn3okMYslVQx5n8akMZiTd3+VQpxJiLm/0/WCJHEksn4O0e859zmMDvvUOsA
         3zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146870; x=1778751670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCxd+5uv4hdNBXidMCSMq1z3BpfTFZGcppb4STtJd00=;
        b=kMpJGmjKVTH7nI1V+r6OpOPnWJ8xfNUVC/7J6C+WPeTwzOlBFbDXo3Jh147j8TbQOT
         Dv4Mk3SdCThY50hqkhV9BcNZnJdk5DBDKix4jwr88PpulkosKN4ejcNAQLAhk7DFOik9
         YeumRgrLmAXQunC3n5t8OK0pJwcGp1WpMna5rYOWMPBHVCAipBy6ogBmoK3FQtaqd6Sn
         CiSljwcZjbdAa5BjPc/q9dNIRJILzl26C68O3iJC1gyFTEz0lju9IAVGp/vRpO+rHFLj
         F5XdCGCa6iAm+/+rPNQv8fHpEr02wIj26LkcnAdUCJJoEAxgHkoFxjCeLyMtk4rk6lXu
         Y26Q==
X-Forwarded-Encrypted: i=1; AFNElJ9GVowmxWcE1Pps9brCzB8sPnhXx9fbMrR0qIV8ZzTnPjrNn6rTKYX1hNPV6eyZl0m/xMOj4E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+1eTgsbUZS4C7t5jCIvYUU9jRD0PDMiwuAhwzZmmT2WikBy3
	18wRvOYMqTlB/dH9J4Do9TsQcWPpq12+jTP/9FonPB2ho3Nr4+oHNJFfZdyjbznn5b5PL76oC16
	a+qi1hSpT1DzFAMTvALYq2Lk+dfvCFPo=
X-Gm-Gg: AeBDiesQHgJnugsSjr6+rtz7uz7m5xtKxIvoQDHxux7QY9qQQ33O828pfqLTVOwqiro
	kSMKNOIQTCqiygx8idReJFEAOGOORLEqsqYDdFTTiGqZxYlbi51DR4UvVQ5I92KkFUz7SH7vvz6
	opGLHAe3NF1hi4d0/CT1Yy8sWObeYKzBJCngb6iX2yh3PHMgWxjBrTi3qC1Xd1IxZVXrNMWWBcx
	bPkGdZJC3dYqljS4EKhZOkd2yj4EJD8XUWn0+3GJaGCXHP7EPFkW5+fbsMoeNFRaTgSyXLlhjGD
	y/brXXLjHW1K7iFryzE=
X-Received: by 2002:a05:690e:1516:b0:65d:796d:8f00 with SMTP id
 956f58d0204a3-65d796d9d08mr2772997d50.41.1778146870374; Thu, 07 May 2026
 02:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142434.643523-1-lgs201920130244@gmail.com> <afv21xfKE9PxGWuD@raspi>
In-Reply-To: <afv21xfKE9PxGWuD@raspi>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 7 May 2026 17:40:59 +0800
X-Gm-Features: AVHnY4KYf5mnb43sXj58-NXgedFQvaoKgE77KqA04IMyO14JzMOPYqCJb3R-yfY
Message-ID: <CANUHTR8BS9fo0a6s=+M6bfgCgcWtrpepg3ayv3F2bkDoWkYmDg@mail.gmail.com>
Subject: Re: [PATCH v6] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AD0E54E636A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244541-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,nxp.com,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Action: no action

Hi Liu,

Thanks for the review.

On Thu, 7 May 2026 at 10:18, Liu Ying <victor.liu@nxp.com> wrote:
>
> On Wed, May 06, 2026 at 10:24:34PM +0800, Guangshuo Li wrote:
>
> [...]
>
> > Initialize the output
> > argument to NULL so callers using cleanup variables hold either NULL or
> > a valid device_node pointer on error paths.
>
> I'd rephrase:
> Initialize the output argument to NULL so callers hold either NULL on
> error paths or a valid device_node pointer on successful path.
>
> >
> > Keep explicit of_node_put() usage in the helper and in
> > imx8qxp_pxl2dpi_set_pixel_link_sel() so the fix avoids adding more
> > cleanup action usage there.
>
> This sentence is not necessary, so I prefer to dropping it.
>
> With these fixed:
> Reviewed-by: Liu Ying <victor.liu@nxp.com>
> Thanks!
>
> --
> Regards,
> Liu Ying

I will rephrase that sentence as suggested and drop the unnecessary
sentence in v7.

Best regards,
Guangshuo

