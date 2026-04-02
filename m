Return-Path: <stable+bounces-233067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMJ+CEqczmnfowYAu9opvQ
	(envelope-from <stable+bounces-233067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:41:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7812C38C141
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09F430D01DF
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EA83F0774;
	Thu,  2 Apr 2026 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKd0tRpw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85D3E1232
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147542; cv=pass; b=A0ycSK0oX/oCM5L0zU/PaRZk9+ozwrlSBgHsVhXr72vWTSX3lqp2SZBRMMHlKEQYlxU1QYD8wjiM3cXM3DvOkz+qwEUHjOtYh2JJIrEDZMHdRBRKMiFpOBsfqbGk8SINORRj6cra8wIUtUx+nrincgU0miAT5d+RrMbwgXcwN6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147542; c=relaxed/simple;
	bh=3rGC5t73vzjsE4isLGN6gcRfLVqx2vV7zj/l2qnrfbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlEdm1o3rHBv8RxWgDZI4soQWbHXEwGBm3FhRf3QY4lZROKrh72X2/pLhKJ+p/nPyBFkFjiDpnGR67YCg9vEh8CC135XloNLFfGkEGhl8jwfs5AqdMFTg3YWJBOoEca8QMMoCAF/PwjBKLc2p7dB1qmiGqqgF7aTu+7wmdk7gpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKd0tRpw; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so1603166f8f.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 09:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775147539; cv=none;
        d=google.com; s=arc-20240605;
        b=bQZkLia4n0Dinto3H/aJrt2o2N8VyRP+s5LxQGRh6wCo8+IViMhxslHK/TzdDem+ds
         Cvfa/mlkpoEp8yQwq/U6NodFCMKgLu905pvOUFCYJmL1CPlRA1gyOP+xNbaIKCHgSWnx
         j4qKnMqKq8lGr137Mqh316naTXsclaoCnnnPIZI9X3QYs94w/YeBbPvz0VDk5EVswpgv
         V5o7f3REDz286oj174BtT+QoS0kLjvxl7/bJBS2NM+02X7/Z2WxxmeiJ+UKHbDStOTfK
         6LvPLqM8KoDoDypu6f32xe3aGDfSUrPw1KJ0Tf+CUVCn18DTo+pWAQ3YZBiQ9G74jXwu
         wP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vp4MNzcCedf5x2a4aXVZOAyoExIlbvVQis++ipw9Jbc=;
        fh=qNUekZFJL2HKPC6b7bRYyylFbjS4rzFCmOJE/rDaZOs=;
        b=kxMl25wRsQ3AKlv6RVUKps9Y4B1QyIOS4Q8xa8KUHfjosELyrt3PCOZDtCwqiOTdM7
         6d9G3lRapBA9cm3cCRORCleVdvtbqifgCztlSVphn3urFXFV32bBkmJgNaVxAXrPj+LR
         M6+iK/OlXlJG+CY4dwza/YopawXJDpPnHvtW0VdohseGXmzCCn3yXBPrwIKYuzGg0oYQ
         B3b5Zub9wWNxE8UM90MJLpVaatBnfXcYIzhT/kuFKPEi9Oj2qZm2PYc3cEdYAQ3qPHno
         0VlfhMdrS/AP2FUZu3Q+IDa0rT3duMerud5Cx0XYQRcvGPVaSy9SZdqy7zGDV3QfmlKh
         Y0EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147539; x=1775752339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp4MNzcCedf5x2a4aXVZOAyoExIlbvVQis++ipw9Jbc=;
        b=OKd0tRpwK5qVV7VkNnB+9HEO22EeEFLIKqaZrSAn6Rbpg+sYBkMNEruT2IsWLnKOu4
         XisoLDB6lU3lGd3vrKiiYik/6lWDfP/A3decFfBKLuDDbXV+p8E29lYoWhzWiAbphpyC
         InZsTiL2Yrz3jvaUKM54crVEg+nMelkhklEDO4PqrovCBGKVICDVOTHR229fd0wl0jZW
         KRqX4i/x7ESSwsb5FCksjjZFuHaLYs/Iii5DfPrDD2sJdfpEVpmj72/jmPKXzdEFf5A4
         pbcWXoSb4fbmaaoFQpVzBoj6q1nP6WPGjid/K16J/tqwTie8yg6rXcAHrw6g56YJKONJ
         YYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147539; x=1775752339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vp4MNzcCedf5x2a4aXVZOAyoExIlbvVQis++ipw9Jbc=;
        b=iA7k2Br05LpxB1IEKcbc7RJgovZk2U06NrT8rOUaoSDL4wkq4uJ4fcngEF3BVb1BPc
         N2glI5j0EdXuwq5RlX6XmwDlOb2tT5OlcGrpyCyhDAFWGABKSO6MMyuI3ypI8YYrvl76
         b4edATV0M0sUP8YCAeiGemVhsLI6QRCZ/qii86DkCUFaFkeI8skl+OoR8jCGYPUAMtkY
         qGY6J4VvVctE8tumx8IWYhVt5R5qUiI6ai6gC2sduDNCQdWpkdPMeQhJYWAFWDuQbA2u
         /7rXNfDWzN1ixcAFFHXcTtb6//NaEZRW5fmb/451PZkW1OYK5ruz889jbY8A822VSV4+
         6wyw==
X-Forwarded-Encrypted: i=1; AJvYcCUMf1bkM+wCxKwMffxnTsBJBWW4BeAeGnAIpLL8QtHzgP4Zbdk1qm8LrAXq6dezb9c65sXYgKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/PwlYuhoboHmOKMWhW4dY2nXov7GKaLWhOGWmJOgKlr6yn1R
	UUJ/AR0DHig+k5+T7BXnGXmH50uwxwLVGnpCNcyYFAmrbC49hWjnIOgZLb4GDa8SwH6YE8m1tMP
	fCYkQ+fgFL+zfslLsgpwjwMpL2AxSU6M=
X-Gm-Gg: AeBDietOy6R1WYjyFsuCudaFOCOKJ+69lzC6/USahumMF3C+L16+lmG1IaixA8wDU2B
	Xph+dHKsbJQrUaD2bNeOOjijqeQ40qx/dOQjf0NaZ4ACgiEuqla7ljQX6qiwiSjGYVVLR6IGGPi
	046m9shc6e9jbCqMsq+/yOH+2DlGTO/oJnlBG7EiVFXmgeRCAlHCowuYTE+0mSbrWAapsVnhGqM
	tZR4Pm8LyV4KMq2JYGzuMz4F+6eOKwC0GMikJya0fqJ/u8vlOPzDo7XGwL1UOKzz5sWAQ/1quS9
	w+/fSg==
X-Received: by 2002:a05:6000:144d:b0:439:bee4:8a93 with SMTP id
 ffacd0b85a97d-43d21199d74mr5350789f8f.12.1775147538819; Thu, 02 Apr 2026
 09:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401184915.747714-1-joannelkoong@gmail.com>
 <278724ec-0c5a-4b3b-b4d7-c5a3c0ceef3b@bsbernd.com> <CAJnrk1bH2_hk=mfbk0Ac+9UQV7bPHuD9CseWDhj623um7NmdgQ@mail.gmail.com>
 <33b0c367-d1de-470f-8e26-4c66a54cf48a@bsbernd.com>
In-Reply-To: <33b0c367-d1de-470f-8e26-4c66a54cf48a@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Apr 2026 09:32:07 -0700
X-Gm-Features: AQROBzA22XfKoWfe1Zi3PBMxICAwbta_mmHrPbZpD1WLQSerKVqwm8XyCFfVB7E
Message-ID: <CAJnrk1YFU7vb3DRhxqD7p7VZfiza3UY+vDhFZmX+ov-pU+HzUQ@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: fix io-uring background queue stall on request completion
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233067-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bsbernd.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7812C38C141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 2:11=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
>
>
> On 4/1/26 22:35, Joanne Koong wrote:
> > On Wed, Apr 1, 2026 at 12:49=E2=80=AFPM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> >>
> > Hi Bernd,
> >
> > Thanks for taking a look at this.
> >>
> >> On 4/1/26 20:49, Joanne Koong wrote:
> >>> When a background request completes via the io_uring path, the
> >>> background queue gets flushed to dispatch pending background requests=
,
> >>> but this is done before the connection-level background counters
> >>> (fc->num_background, fc->active_background) are properly accounted,
> >>> which can leave pending background requests stuck in the per-queue
> >>> background queue.
> >>
> >> I don't think it ever gets stuck. In fuse_uring_flush_bg()
> >>
> >>         while ((fc->active_background < fc->max_background ||
> >>                 !queue->active_background) &&
> >>
> >
> > If the queue already has other background requests in-flight, then
> > this check never passes due to the stale fc->active_background value
> > and all pending background requests on the queue are stuck until that
> > in-flight background request completes, no? I'm rereading my commit
> > message, maybe the wording is unclear - do you prefer it to be
> > reworded to "which can leave pending background requests in the
> > per-queue background queue stalled"?
>
> From my point of view "which might reduce effective queue depth to 1". I
> certainly agree with the fix, just not on the word "stalled".
>

Sounds good,m I'll send out a v2 that uses your wording.

Thanks,
Joanne
>
> Cheers,
> Bernd

