Return-Path: <stable+bounces-272220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oO3MLlGqS2rGYAEAu9opvQ
	(envelope-from <stable+bounces-272220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 15:14:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0367111CF
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 15:14:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pmPTIXRm;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272220-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272220-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0724303B69E
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580CC3FE67A;
	Mon,  6 Jul 2026 13:13:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F33F44F7
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:13:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343621; cv=pass; b=D0Ky8IMY/Z+CBkFIjO20TTNQGoK+ZONMk6OCuz3yBV6sG++y706iB+c0wceTFKYh5unGbV745HPnL0Zvpis2whkdjaa6XKlxnQTxQkGRnhLY2G+/wIKTL3xEKCTZowcCz6GIjgP+EVEjSvjDlh9GF0EHW8fclLMzmW7gojDzd3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343621; c=relaxed/simple;
	bh=W06a+FQhE9CYhRDkSX3d1qnVPXMf+V5F//o8j4fuNbQ=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKo285xgEH6iJiz36KfpQKW9c774sjLeHAyLbHwRZ7OmIVePO407bQgq3cEqyTEPgr9LvUY/DMmlWVCrQEkuyrm81GgnYZYgj3lRwNtG90KrW5ccLoU3YubjjHQOkNk/D2E4WckmAm5Nd9JiMKMNHy5D2tMnpoVQtoUDHIuLUeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmPTIXRm; arc=pass smtp.client-ip=74.125.224.45
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66780d9d901so135864d50.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 06:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783343619; cv=none;
        d=google.com; s=arc-20260327;
        b=hU04N2KxoF9U0+3BFHQOseQBVlOrWrw1Ui1dHucjjVFigi0pWfKVij75On/banqIy4
         WSaTEPzWWxudu6L1e4O5BYGIWwsTqVQtOM3g0i4+xSxFAX/3xx7Yec6X0XwVENzlTIBH
         k3d4wv4oFkK/mOvXpYV9sW1jqpg/eUOgxSiHfjvBHTzVI3UNcM9rvLpw1+ESan0Ms97u
         vt5inZC4Dz6Y4Y9Sm7i1PS1RbsbvQdpm4vbzt9o1RQ2QoqKNhB9eKcBcap+leYnC1QG4
         YqdXDMiwYcunxdJYexpBY2VMnEKWr62B96BxgWHE3jWbT/jtC4JklAq3G4+PEwe54FC3
         pGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=W06a+FQhE9CYhRDkSX3d1qnVPXMf+V5F//o8j4fuNbQ=;
        fh=D/Ah8jlOVepvHsQwKWVs9IzTzvTmJJdOzmwQ9JdtxHU=;
        b=iK7DvNfE20WtnAUCVATJ0Dilcnd5dbQAPAmswI44mBAtAgMxyXhrY0kFEL+gMaCLOK
         GMePyog+yKC3f60uNoiHVT3CkrIQuv8EFmwQyHwKnS+xywYRWbnMEJtfU9lTZPKuA48p
         Gc1F0+IZfyWHiCnsy+Nhrab/geLbDCadbfTuez2yW67awmQIjRIytCEe/etJ8Coz3xDz
         IyZEgy3xgfwr+G7nNRNN1CYIzIKYo1PXWNOTa+EFkFdFxxekBLtTj7N49NwpsaT67/2I
         6L08EYNa8ZaEkooD+Yss62Zy1soDphRWwZSeVUIzESo//aYtF1g0yt5FSGFUd2xSaoc1
         l77w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783343619; x=1783948419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W06a+FQhE9CYhRDkSX3d1qnVPXMf+V5F//o8j4fuNbQ=;
        b=pmPTIXRmO7vK65MG9ApD5SjHL9fhCFKp0fke0dtwtu3aQgc1lJk/CKTwMDi1EqMP9v
         7F+aON0sSf+W8t8PsLgtGv7hPPaqKgofgs4K3Qe+wPGllK5AeQtrOxPNVAs5q/iQJNa5
         ACK+bhGfyLsI5Q8ju6YTiFUYSy2WcCjDsD4ww3C5iqUTEmRch0VGiIKcXDhg4WU7qFfk
         HOZQ2GV06DieUp5OmueLfAvSePkgY0SwL3KdU27IqUoQBCI1+9L9tAd7RXbMlVYzZEI7
         XKhslW78rzHFHbdup4+id3SOEtef00yhvMSOXaxV8usxtlHaoHu9xpUD2yGqjilGweAW
         uYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783343619; x=1783948419;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W06a+FQhE9CYhRDkSX3d1qnVPXMf+V5F//o8j4fuNbQ=;
        b=E4OPpj7Kq3vfcttLAs8xyTXZOdmUVZzKVaCmum488VfRhkTM5aKEGNjziFdtSesQVj
         fm4m6pl30ddO80YIvoXc6wictOhmBpYu7SLPMwBftbMIFNgCNCVWLsnz2J6mUwPc4L8z
         meiWVsIFT5OzObZs8byzEmZUsXdJl3UwYdNO+Q6zoBH780+W3wwrVRzudVVTgXHKjcBb
         gF2bwWh+WXOMllWSj3MD164HazHys3DC6BSjTwFn4w/Y73F/ykIUuNGEaRdwhPgROWwB
         WTxAsoZu3VolzRepbCC3GVWJVXctdQdG/sm58SH8AeBeatMoFLsAHQ5kQ3i8c21eJoiK
         ZHIw==
X-Forwarded-Encrypted: i=1; AHgh+RpQoZLj7DYYS7KEoJfvKs9guQKD9A/oe31ndkwih6FK/vi4rVg4eAb6aoJ9lxNtBWjABRNMlec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdod9YuqhlhSGimFoxSAZpN9uvsa3yqH3RAs9kcpsIhQPM8/1w
	vjst3EKLsTaO/ARwzYqCtH091lQlbqdFu7uAA3YNeRoN72wxPqix0K27ps+5KZo+fIMbq8cA4qg
	FwA5kIKXB2KBy2FvBCvABpUYOU26GtIo=
X-Gm-Gg: AfdE7cnok+ws4oRvNuUxX4ketM0xKiVUFgEhcaVZ5TseJWQ0olKJoFvSHJZN13ftg03
	4xcOR5pMQ8+8qzwdyC2p5xLYdW5TKR9ffFvKPK/4zDrwq4S131DMpU68WI+UjM2N7hWg0crJtB2
	FO8+cDb4cENZzjnZ3AVjnmP32+/eQVibt+/Hp0Wicas6DJE77RauTSqGZACb4y/HqscponWqpE4
	S3RULvZ5K22enGMwd6+F95l8zhCuTKT5fMjJ7Ft9u1MCUr6imhajb+tc85hnzdCyjaevXi9
X-Received: by 2002:a05:690c:ecd:b0:7d0:79f:339f with SMTP id
 00721157ae682-81be26663bfmr1394177b3.34.1783343618557; Mon, 06 Jul 2026
 06:13:38 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 6 Jul 2026 06:13:37 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 6 Jul 2026 06:13:37 -0700
In-Reply-To: <741085b4-3892-487d-a39e-75c62a7b6d0f@gmail.com>
References: <20260628092814.40583-1-alhouseenyousef@gmail.com> <741085b4-3892-487d-a39e-75c62a7b6d0f@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 6 Jul 2026 06:13:37 -0700
X-Gm-Features: AVVi8Cdxlr6gMWVrPELRICnA8WPxAFKLDWDEkWzm1kURK7XCvcwCoYib2Y0iWP8
Message-ID: <CAMuQ4bX_z+j7deGvKWGhqCApjwbWNaNB8RT9vpfPhuZ7Mzt-+w@mail.gmail.com>
Subject: Re: [PATCH] wifi: carl9170: reject mismatched command response lengths
To: chunkeey@gmail.com, chunkeey@googlemail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272220-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@gmail.com,m:chunkeey@googlemail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,5c1ca6ccaa1215781cac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C0367111CF

Hi Christian,

Thanks for pointing out Tristan's earlier patch and the prior security
discussion. I had not found that submission before sending mine.

I agree that returning after carl9170_restart() is not the right fix
if the restart can unbind the device, and that the copy itself should
be bounded instead. Please drop my patch; I will defer to the existing
discussion and will not send a v2.

Thanks,
Yousef

On Sat, 4 Jul 2026 21:56:30 +0200, Christian Lamparter
<chunkeey@gmail.com> wrote:
> Hi,
>
> On 6/28/26 11:28 AM, Yousef Alhouseen wrote:
> > The firmware response length is controlled by the USB device. Although
> > carl9170_cmd_callback() detects when it differs from the output buffer
> > length, the function falls through and copies the entire response into
> > that buffer. Callers commonly provide stack objects, so a malformed
> > response can overwrite the kernel stack.
> >
> > Return after scheduling device recovery. This also preserves the stated
> > behavior of leaving the command incomplete so that its waiter times out
> > and clears the pending output buffer.
> >
> > Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> > Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
>
> This was posted earlier too:
> https://lore.kernel.org/linux-wireless/20260421134929.325662-1-tristmd@gmail.com/
>
> In fact, there was even a mail before that that was sent to security@vger.kernel.org.
> I told Tristan that I would much rather not return and instead fix the memcpy.
> carl9170_restart can completely unbind the device, so it's unlikely that one would
> see a timeout.
>
> Cheers,
> Christian
>
> > ---
> > drivers/net/wireless/ath/carl9170/rx.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> > index 6833430130f4..ea3f435fb64c 100644
> > --- a/drivers/net/wireless/ath/carl9170/rx.c
> > +++ b/drivers/net/wireless/ath/carl9170/rx.c
> > @@ -145,6 +145,7 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
> > * and we get a stack trace from there.
> > */
> > carl9170_restart(ar, CARL9170_RR_INVALID_RSP);
> > + return;
> > }
> >
> > spin_lock(&ar->cmd_lock);

