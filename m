Return-Path: <stable+bounces-211527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GMcArwld2kUcwEAu9opvQ
	(envelope-from <stable+bounces-211527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:28:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3153A85713
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 499943001CE5
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE35F2FB632;
	Mon, 26 Jan 2026 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYE1engo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D01624C0;
	Mon, 26 Jan 2026 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416119; cv=none; b=s1cEzpCfdHuDpoMhHmoV1X982GYKHf+NulIKtrRPDAHrskPUOMKtes33QJf0Fd6N+X2ZXlTfmZcl3pqaUxExFmpemL6leVM5dhXSIHAMOZCprnTSrvRr6FahsNV3XBFVKRh5jMgsdJDi/9ibCRBjvqeq4U7I2saRkUj7vxg2iZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416119; c=relaxed/simple;
	bh=lPRuxd5l/tcrhp290qRLo8Aqicby8MjyhGpoV7lymug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tliTgT5gOpjFAtFaRMsEDE+6k01Asj7Pnh1fv8VkMXaNaQ06Rawbl6r1JvTO9ZFamUJlL4G0u8BFyDlJyhSDrfKjiaOHvKXJpLt5fQmkq3vTSG5LAoR7JTa6U4E1eUOH+DAjQp1AzflI1f+ZNeEkuNiaIMkwxrbJWmHwdmP4ouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYE1engo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BFFC19421;
	Mon, 26 Jan 2026 08:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769416119;
	bh=lPRuxd5l/tcrhp290qRLo8Aqicby8MjyhGpoV7lymug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYE1engodk8o0/IepcOpxN5MMOOgVDG8s6T7dTmwt7zwkg0/YvWl5gmb3XNEs1sK0
	 4m3JfcVBwP5vHwXFIF1oe/IUSeybWv8RkkufA9kh90PHft01AnTBRgu2P/WAydjWmM
	 Eg8UH27geLWia2kl/Js9Vo1wyL/nYo82xYqDp6r0ogdM4tsSHZ501I6oI1xo5s5qBA
	 56+AE3CaWx2bg3D2wQG7DKjIoXR2P6KJ1UAjHFDDLOuBAzuBVEWXarCZNRaekO+2A+
	 4A3V24qb0x/JA61FFbdVnRsC71LePVQp2LHg3W/16ko0w/gIvMD3ao5Hy36siibsxv
	 YVu8zDidqGOdQ==
Date: Mon, 26 Jan 2026 08:28:35 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: briannorris@chromium.org, jwerner@chromium.org, javierm@redhat.com,
	samuel@sholland.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	chrome-platform@lists.linux.dev, dri-devel@lists.freedesktop.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 02/12] firmware: google: framebuffer: Do not mark
 framebuffer as busy
Message-ID: <aXcls56wL0BR8B1i@google.com>
References: <20260115082128.12460-1-tzimmermann@suse.de>
 <20260115082128.12460-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115082128.12460-3-tzimmermann@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211527-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,redhat.com,sholland.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.linux.dev,lists.freedesktop.org,linuxfoundation.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzungbi@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 3153A85713
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 08:57:12AM +0100, Thomas Zimmermann wrote:
> Remove the flag IORESOURCE_BUSY flag from coreboot's framebuffer
> resource. It prevents simpledrm from successfully requesting the
> range for its own use; resulting in errors such as
> 
> [    2.775430] simple-framebuffer simple-framebuffer.0: [drm] could not acquire memory region [mem 0x80000000-0x80407fff flags 0x80000200]
> 
> As with other uses of simple-framebuffer, the simple-framebuffer
> device should only declare it's I/O resources, but not actively use
> them.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 851b4c14532d ("firmware: coreboot: Add coreboot framebuffer driver")

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

