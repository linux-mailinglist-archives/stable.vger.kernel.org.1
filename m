Return-Path: <stable+bounces-249755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDk1MjxQDWqgvwUAu9opvQ
	(envelope-from <stable+bounces-249755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:10:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7666D58805D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A68BB3006D4E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E859372075;
	Wed, 20 May 2026 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="tl4rADEy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6585C367B83
	for <stable@vger.kernel.org>; Wed, 20 May 2026 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257396; cv=none; b=J4XERliooiUQnfqCHvsjoUGoV90rVpgqnnRQ2IM0W/QvpPfjf5Hbt4rN52l5HKLZedhyZG8JbQS/HFdh1xAu147h1Y6eGGdqar4oasAGUqPTkrI3u5dGPwwVU8YnRSyg/IysqzQXTryZyHWpy+VdTYA6aXSNJAxNy1jtbyoMKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257396; c=relaxed/simple;
	bh=u4glTfwvM4dGbYgQKUctExrwFgihW+Oc6Hx0oa9U1Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvACv+x2vnZg/oOYYo1vzIARinUIK1LtzZAmqGMyEygSnEDinieEtH0/GoXcVwfYArpxqgenK+4zUSVu7Yp5dZP5jRm88lPRFGAPtj9DuHI4apnBF8g7276Q3TGunld4IJ+Qbz4MY2l+WYv39FgCyhGuwJTaPPwWs2W+KbE8xrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=tl4rADEy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c796163fac5so3785196a12.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 23:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779257392; x=1779862192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WvINbRjPBtxpZCn+GO56O7dJIfiZjHEq3Bb0sZJ+Zrc=;
        b=tl4rADEy9wIfwp4zrC8ZTAKp/G2O7p4fBsNKVna5GvpYr2IddbUDd9z33cyc5j9202
         Le0wjxuTNzk4fKVqwaDweNzCmd+j8AFuAGKbd5NGCRaDjvMMx+Ds59i143FGCss/dZAZ
         JdIt+0yQGf9j5Z33tQuTUTuhNUd1nxvp+21zV6JeKTXzR/J+o7X2vpAmoPZOShiOi4Rl
         xkhA9ExFOMHuhSqrd7wTsTtxTukaT6CNqdmi5+nl4yePOiUnSivjn3kzYmG0z8w0ot0R
         SXJFUtRaw9wFYhKvxHCOyox0f0Y6NBxzFlOLGXwDvbaiSPZe0t5T6SQZsU321FXcNbmV
         AeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779257392; x=1779862192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvINbRjPBtxpZCn+GO56O7dJIfiZjHEq3Bb0sZJ+Zrc=;
        b=HBa1AyutuMrT62dICfjs9FfDtrm18oHjb3NwRvQMswZCdx2rc+q4072GzqD2BoOI9v
         +arFUTG6odgiVDqFWH8nfCv1C4j21dvXYDzupnpgZW603puQgaAglSFBGgF1tOWdVr/1
         Px2dTwT5EOXmT8RLALnWhPf6ZE4kn40+xANUAQAysvUv9tsFz8vASV0Dzz+zza7SeRFJ
         T+gqbmrd4c8OkloU/o3RxejgYgSgee1Iyu88rjG2IWBFtjQjxYoeD8ZVEPnUawbqJVJ5
         +gq3wMEdsaSHicUfqUvOTOyiWMfO/Of/5qzrtZLHgKKzwARPnJUq+U+vG2bZVTQ1AHOW
         F4lw==
X-Forwarded-Encrypted: i=1; AFNElJ+N29U9D/+qUUzK4PDgUq6HM/LjyFqL7kOcH5EQ5mbYjnfk02Cwh+or6lYB3rQCKmPYjE3O/nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGuMB2nMirydvuAKwRuLNXccmcqgRCLAgvZ370Q0I+yViYwGi
	CSzLCZ7WvdQoIS6BaqhnJ/K/CdnbuBjKLhebY4SpiQ3DeJC/KJOSfXUIWuFksx1ZyCc=
X-Gm-Gg: Acq92OF1YkWpdcR/UgqNwBeWmBh+64/AXKT4rbCTbzvAbem7kpMmdJbfcoDcPpNjcJg
	/BOV6DPe2uVuWNeJW5FuiAm/a6x1tFSCHPC2yvTj4MEumHUGTzBt0FDdnIZklSuOflFQ8e8hgCt
	FWGxh/VUSr33scwB68mMhnfZvzz8wKMS+xKhtWAGSpsBId8afKgwDUOGmofokquebw5Ka6aQF57
	ElldUTG3IwaSs0hNLoO6FcZ0DyjV/JGNCxZ7xPWD80xzNOx2bdg1GQX7xA+WrSU6ORIdU8qfCZi
	IePUzTe7T9DCIEDY5aH0l34qZNVq7xrI1R/5zMvithVNDWjWs4KEI0O8sFoLtLu7xJf7b87/bCO
	FWCDBPZr/ufDarkt8qf6dnDR6Z6mYYMmPuRpVjwiYjDkMvAFmgCOh6/N6mVRPO3iDhGiuLmFJfQ
	d20diSZwbvAungaZWBcXNhEcktT5CMiDaYe/YGSmeVmPrbYq6S8TbXl6YZ7wOWBy9zE4Q7mth+a
	u0VeNCg7BRueEe9jjq6ydjZXTJljN47ESk=
X-Received: by 2002:a05:6a20:158a:b0:39b:dc44:eceb with SMTP id adf61e73a8af0-3b22ed28431mr25802680637.42.1779257392565;
        Tue, 19 May 2026 23:09:52 -0700 (PDT)
Received: from essd ([103.158.43.41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1006fbsm17751895a12.21.2026.05.19.23.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:09:52 -0700 (PDT)
Date: Wed, 20 May 2026 11:39:45 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Justin Tee <justintee8345@gmail.com>
Cc: justin.tee@broadcom.com, paul.ely@broadcom.com, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jsmart2021@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: fix potential memory leak in
 lpfc_read_object()
Message-ID: <uetljgpjg3dinarrtv2fkjieohsh7te6agy37a5z3wskfqnr53@ota7uhwzrdiq>
References: <20260519074230.110624-1-nihaal@cse.iitm.ac.in>
 <67ad1039-b6e7-4507-a9be-12600a5fe385@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67ad1039-b6e7-4507-a9be-12600a5fe385@gmail.com>
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249755-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[broadcom.com,hansenpartnership.com,oracle.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7666D58805D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Justin,

On Tue, May 19, 2026 at 12:52:36PM -0700, Justin Tee wrote:
> > The memory allocated for sge_array inside lpfc_sli4_config() which is
> > attached to mbox, is not freed in one of the error path in
> > lpfc_read_object(). Fix that by calling lpfc_sli4_mbox_cmd_free()
> > instead of directly freeing the mbox.
> 
> I don’t believe this is true because in lpfc_read_object(),
> lpfc_sli4_config() is called with LPFC_SLI4_MBX_EMBED.  So, sge_array is not
> kzalloc’ed.  The code as it is today seems already correct without this
> patch.

Thanks for your review. You are right. I had overlooked the conditional
and the early branch in lpfc_sli4_config(). There is no memory leak
here. Please ignore this patch.

Regards,
Nihaal

