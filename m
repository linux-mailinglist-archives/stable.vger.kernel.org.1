Return-Path: <stable+bounces-244614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGoaFh3P/GlhTwAAu9opvQ
	(envelope-from <stable+bounces-244614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 19:42:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3174ED011
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 19:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6911E30948B5
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E336477987;
	Thu,  7 May 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afpZuCKm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8A477989
	for <stable@vger.kernel.org>; Thu,  7 May 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175588; cv=pass; b=Gvbpg+0U1i7+0J3bUGU0pa2rjVmA5RZ0QSKz9ErT/m5RwSj/2xTaPO+FPzlpMVEJjCHjJiUwsAvd6B2vzcxcLvQUp83sR7/gLc4IFRVN09AsPEcr1AlxRA3iMIQgnMKlLx0amTJktLMDbmqOzpLE5sgaqjeF4u7TOMP+Hra4QDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175588; c=relaxed/simple;
	bh=ohsR/fIMQJjHroY/YB5ZaOasovAVfheXp/CsvW/39HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkMYh4grt+zikyfLB5oqVutXt5iKvVGVAh3JsfKvzzyW6X+wHQVLvkAEPYxskfrGs90CQQRlQoWIeG9YrW7HBctSLS0S/SbvkSxObuLQWekcMPwDnyteRQoUx9XdTfrFrSZZvcOwj5cWVQarJDadGLK0bBuJ2uLjiJGk+gsdnbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afpZuCKm; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adff872068so6408735ad.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 10:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778175586; cv=none;
        d=google.com; s=arc-20240605;
        b=bZxZskXXJZQam8uZbobSS1zzqNGEiejNdJGxDKMxNBrvn5HcwhSubZG0gtNRWMiW5X
         dz5SDqVJy6OnI0yo6SaTX7kX7WUhsS1/ZqUcR3wBOFBrc251TG8xwjAJG/DD6xp183K+
         5FlYSjGQAlM8sCNe7SEJlZl9f+bKTu/P6MaSS/ig3Go/bjHz1xe+iO6O7JnE04HOw8or
         ATZ4CyvC6LtKOyslo4j6xGBcIbNmZqij6uzlJ+guU8dYNU/LYx7VJ4bzzSZnf1FFUOcf
         MRt1Vfi+y84p6QgVYcA62sO5qJI/UJHyAgFsq4XNelrnJRQu5FEpUFpI0qieFJ6MfEmO
         6P2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f8+wFt4NqJIqcJNAHfqYFfrJjs6Ue3R50oWtEk7OHbw=;
        fh=FWIv0R2fBvs3cJeGjGVFCunWiNua8tksKYsLAZNZ0oQ=;
        b=gsPCA95Aoujvm72dc44iw1/j8hZsmyAMX0R6/9PzrE15TkVclnr7WHZl4wseBwwr/P
         PPX3wqs/KJ8XWFGnwMgkW4bjoLnYTsa8j89xFSPeYFFirmjRowITmwCaHT2P0cI1e2Fm
         14958V02s7fZRFTs0fbgld0TzSRIP8kpfo+z1QSvbB1qNYg4jItqAjL+jlRoUZYKXfdZ
         bHA1wiXSe7kt8Ihzncv0VJaK1d5c9QCfov8vk3xF6qpvygp5W1GgFPfj3IYLz3DYXCPN
         gmcsGhymUSKDgSFo+2eTzwJho5pp+AssdbReDX0dOazZ0tQ7mwNQZ3XWVEc1wMD75WKz
         WRRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778175586; x=1778780386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8+wFt4NqJIqcJNAHfqYFfrJjs6Ue3R50oWtEk7OHbw=;
        b=afpZuCKmsJg/s9mcyZEn+/7RkeP39TDKb22mXcvnFeRLuc+gdYmwWLz/ZbCW4Xt70Y
         KDQmlMX5rI4yQiS/oCjM2FoX/mZHFaPIU4iN5JkQjSpCQ1KCjSVXMzIral274hcD3Bcr
         tS9G11xMfhW0YbdUPX+bt83QpA40i7/0p/55qKH4Cxb0O65PHUKQwPiESpOk8/yce27R
         xywfMIqT5cd/zNo6UPHQ4/av9sxJOm7qwav4TBMvfXB089rYCDn0QFnYWRIV7IejH2Y9
         RErwix/RSUfefst/nkg5YG77g/ozBqXVxSiWGLQ4mhOA0m/5RYdLarGK4yt9/5j9cing
         MG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778175586; x=1778780386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8+wFt4NqJIqcJNAHfqYFfrJjs6Ue3R50oWtEk7OHbw=;
        b=kSgGcBgjZ3aj3d2A5GDZ+Odr8H+paOPU1ufWtCCnygVkXhQCUbkbGDVmRuVCNxSOup
         zdEvM/z7mZwt/sdS82EXxBf2TNHLH30KgHK0vAF25sk9f2ntmWijpDpDfUEm0TYfeZ3Q
         CsnDezD7V/Jqq26iVDf/Kj8PlXTuzUQwj4f7x6SLZOXYhRScljrJcTzpvx36Bnjp4Wmu
         MaLRIp3DTABaNhoRXG/rTxhOQwWO2GBCmRLovidxIiGlW1WzpfczciRnJ0VD/FYi3SBO
         r0jZlLSayb56H7VSZ8ALBPXGL3ezXMN7VUAtvR7Q+Ljp49t2iqHM0DRQGot7Om+EeKEg
         xGGA==
X-Forwarded-Encrypted: i=1; AFNElJ+LAbqhNFqOKjABqjDOHfhiwNhMBitl82WCZ3Ka9qtg/OZSB8AOz30Fy/LHxn+H7wc5ZI+dtKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEDmJvADff5rg3J3xPUBpLncmAt5/HgRwJ37Au2M25debPOWI
	RrnCYvm6gbk85o1d013hVJhIhcmZBUNoM9S5NugsZns22athdWTfSTyrSpMuJRC8Q1vI8IL1jjU
	BkZ40haUYc4yjW6Xxqk7njNyF26hSaU4=
X-Gm-Gg: AeBDievX046FkLdVfzZWF2VXFseOygMwDI/HNJY2vDZGx3WaLHO2dEQCqI6Hiz0opmU
	SpjvLsBb9P85Z8NlT6ZSCKEmrHAfcY7xSFv4SEPzD/xrrXZMn8Z8EsOJeDyXuOwqHhemrV18gUG
	vapgNBMT9mhb9gX45C5oS0Vv1Z2wGfSd4ndrzkSR8VXiVoxz6eM8DtaGRlXz2OHiz+7FvBhELD7
	sbV/QkRBZfbVMpGrHUpTWOewF3t/0OWS00a9pPMPIHsIUwQ3EMC77gS7TVF0Ri/3BAuGigdgUYY
	rdHBd1o=
X-Received: by 2002:a17:903:390f:b0:2b0:5ae9:ee4 with SMTP id
 d9443c01a7336-2ba79285966mr87114295ad.5.1778175585662; Thu, 07 May 2026
 10:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429000623.3356606-1-avagin@google.com> <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
 <CAEWA0a5zwHKP51V90A3J960e3o3pdVkSUMYwRJaxiD-fkP-JcQ@mail.gmail.com>
 <02a4adb3-8829-4681-b170-e3a2f44bf11c@intel.com> <CAEWA0a5=S+C2pdViHPWykvG0Dj4hbuKFVhSnEzpPWoyOh4oAnQ@mail.gmail.com>
 <c4fab3dc-1627-4775-986e-6b3ea52e7c36@intel.com> <CAEWA0a6nhZ1nXCLeiCdnKi5SjUHiP9w0jO5wuTwVoPO_JYd9hg@mail.gmail.com>
 <562f5687-3648-4912-b230-233d0c23bd70@intel.com>
In-Reply-To: <562f5687-3648-4912-b230-233d0c23bd70@intel.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 7 May 2026 10:39:33 -0700
X-Gm-Features: AVHnY4JmoJoUt9M68Dh1jAiHFBnha452Qs68dTp5pqC0x3BIE8IC9Ne_TuzXnGE
Message-ID: <CANaxB-xrHqh9zcTf3Xp+M_JX5+TVuC6e31nHMfvN1amN6GoxVA@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@redhat.com>
Cc: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	criu@lists.linux.dev, x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CA3174ED011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244614-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Action: no action

On Sat, May 2, 2026 at 12:23=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> On 5/1/2026 2:42 PM, Andrei Vagin wrote:
> >
> > My point is that the reverted change broke a significant, real-life use
> > case that the hardware was explicitly designed to support.
> >
> > It is the responsibility of C/R tooling to ensure the migration target
> > is compatible with the source. Enforcing a magic check based on a fixed
> > offset does not provide additional security. The kernel must be prepare=
d
> > to handle "trash" data in the userspace xsave area and manage any
> > exceptions triggered by the xrstor instruction.
>
> It looks like this behavior has been in place since c37b5efea43f ("x86,
> xsave: save/restore the extended state context in sigframe"). With the
> sanity check, userspace can modify the sw_fx->xfeature_size and the
> sw_fx->xfeatures (independently).

I will take a look at this. Thanks.

>
>
> But, it seems there is no consistency check between the two. For
> example, the size only could be set to an arbitrary value within the
> valid range, without matching xfeatures.
>
> If userspace sets an inconsistent size vs. xfeatures, maybe zeroing out
> the garbage could be an option which I expect still compatible with the
> portability model.
>
> It's still not entirely clear to me whether your claimed portability was
> considered in the original sigframe design. If so, this should be
> documented more clearly (e.g., in headers and/or Documentation), along
> with relevant selftests. I=E2=80=99d to follow up on that.

I will address this in a separate series.

>
>
> That said, yes, this area ultimately falls under the rule of not
> breaking userspace. So,
>
>    Acked-by: Chang S. Bae chang.seok.bae@intel.com

Thank you, Chang. Ingo, could you take this patch?

ps Sorry for the previous html reply with the same content.

Thanks,
Andrei

