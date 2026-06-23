Return-Path: <stable+bounces-267883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5O33HWA2Omp24AcAu9opvQ
	(envelope-from <stable+bounces-267883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:31:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52D6B4DEE
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:31:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gcgF2gCn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267883-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267883-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1C4300EAA6
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2963B6347;
	Tue, 23 Jun 2026 07:31:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD502797AC
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:31:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199887; cv=pass; b=kzepJ9MxzJZsHRGju0zTXEJMBFNwvxKmRhio281p2BWXqX/cDAA+DhDes+/M5bcvb6IC5Up5zHc361AjQR845q6Cyk7dV+mL7N2mrAaJbfiViu+EXbLYSVI17wbuVGfJ18Hu+ER/2OAt9IIo2DmF1J69Y2lEeZERcbMQR52vLfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199887; c=relaxed/simple;
	bh=wNnxLYnrYtZlvSO76qoO37z4hdu8yf/j9NrnkipyBDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eb4g+SnDoPyZ2EI8Lh/lK+mEJhO1OBSI+xVR5dYtL8a9bAssEnur0NlWT+F2H75IhOqyq1YhRRW949jHC1ozlqgmtk2Hfk0i93ZgV75UL5L4j+11kph6Ns+gi80IwcF8dD1kP3etMb5JVLgufV4GOJ7jvjS+wp5POe85p4OcTQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcgF2gCn; arc=pass smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so7526217a12.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 00:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782199885; cv=none;
        d=google.com; s=arc-20240605;
        b=KOXVfMYlPXi2vUieDqbtyRZqYPGe6bv7/jrBQaPwlCxTbDlAc7iBXJCQdsRfui3ZVf
         mty2lknbixwYTc1fuZwAfhAM8h+PyZHb/z+q9Ajv5M1AXRn4PN4g43GYSRZW5T0HY634
         IY9D55r6N7qUxf3SqY5mEfJjTUp6mWe9dhMK27li4Mu8kOoaP1DEPaEmWQTNmtGpikS9
         zvBl80NNl9nI89KYe5g0apzLU0sEF0jqQ6UPG6/4lJ4PeQewGE717nO3SOEfd1V3guJY
         /v5Rf/CP5pHjkhUvcLM6y6LxO0CFRtJk4XUbMBxIFm/bYXR+DMzYiRtXBrI9arMDTe65
         zIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wNnxLYnrYtZlvSO76qoO37z4hdu8yf/j9NrnkipyBDI=;
        fh=8QiywGpUY8upCbNZ+QIJxCHcCV7duXOAEKq2qrLfjO0=;
        b=RQkcKwP0tOr1XfTcKPclJ5uqyej7jDhz3Ko/m+ng+cGeehJI0u9/cSIgNlBPbWJqxA
         b5vNoW5JZFpWzrqLpV+ZkdQiiPv5E3rLY8WfDQWBrCKm6Q8LeAdLbuW17NZt16Tf08Dn
         6YZP1fht7EJYYvKsRlzhVStW3tt7ut92l4Wy1HS22od6K/4RXysTjNt4Gt8Una052io1
         97T3OrtIAG8zpWe06LShFDUSh9Lnd5yF347Y8qWlcIE6mTEEIDVyGKoPuN2j1Y6s4Q6S
         yKYLwPB2RF0uG1vyoxclZA9FkfPtPqWIutOyl9BOSyG0LMyFobSlJNcdgFb2jRbdLZq8
         gT4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782199885; x=1782804685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wNnxLYnrYtZlvSO76qoO37z4hdu8yf/j9NrnkipyBDI=;
        b=gcgF2gCnXkcAW6tmpCuB0TCOMS9d0GuVuiZw0RerJ3nEHxwOr25L1+ZJE6YEwlgAh1
         CYaNIBTcB5IPtz2QuPGcZt8+I8BPK3aHArf1AGkRbxBghRXPe4Wc1dz+v0VyKRTQeWTY
         VpVGgpuPO88/EmiTdE9eh/HzY+XZHAfO9xwTHZBbnYbldGWZHQ8quumFMtos+ALT7uIE
         WgTCK7gn0W8B9MxAOvl5W5BnFSG/BsJLMMIo3Ip0vbZRQ2RQT1n0y2SW6N5JSt5YqD4r
         Znt/1irOoJnOUiRhZLhLjwbW0SZ9QgtpBGUZQb+arhsyIYgCMVCKWz+qOm5qoUl2C/rJ
         UUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782199885; x=1782804685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNnxLYnrYtZlvSO76qoO37z4hdu8yf/j9NrnkipyBDI=;
        b=bcjsxNECNRnDrqDtwVQ6Xiypl8llraSsG+ITHyz1nD3g+rBLgdjXMWAZEhzgvoFqNZ
         gnnuw6As8jCsOeu8NU7XKOGvpFVrtplquPgpO70EPu4xH597KdMzGaAxUC4hKoDpS/bM
         RljdmsxWPFMsP/0Qq/fjyacjhwkq2zodrK7WnEfmXNNzlo8NzBDWiEchgAJP151w5ltb
         IsfnrA4gEBShJFVG0cEA5c+lBjPfBk41REzTSfJzaw9uCnK0aGxJI6DClJYL3BFqlul1
         jcUpiZWyVEMNjzRPZnBR4/YvBNUuNuni58P3YnVcHOX8QwXjnCX6Ujk2u4ZOYyI3coFi
         wLCg==
X-Forwarded-Encrypted: i=1; AFNElJ+W0uiPi1wVVTRAjkRWaoNDqdXsqB93BFBWuZJvsafv6pqOl97ZgDLW2kLYb98NkxSZsjLXobE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4bs9ZlpYjaePNv4MWwdjqgW4Jf0GeD9pkl2iYXVyAP/pWTVV
	HOLbcfpgd1VJWEDq2Ph8ut5+5I1l9WNIgbAf91SJnsdkfthU2g7WBSmO5tZkvVhCyq1vsp0eWH0
	QYguKgv7kcgYhVbcF64WMQRXsq3YIihA=
X-Gm-Gg: AfdE7clb+JnSKmEu8vZMfd1FwTnxSxQ63LalPNULv7lY6I5UxLk/3BKW5/aopSO2VaY
	NFWiHaD95voAueZvQJgyr0m2b+/mPwonOW+hsD88op7+8BHY5ORdrZ+SP7Zv9RgPfiIQ58/Q5ul
	zuHswxkD1aP2HQZZucray301Ln3sShFSkd1CZJwGUHH4SbBcfCsC90rFAbD+Lo68MDaJoiEFV5c
	EB9Eh7jYgtmkmfcV5JAYXibXD8AK9eoJY8VZKJdIKGKMTOumkJa5zqt4awaDM92yZTXtDXhDHjK
	COsmYlPj3J+cT//zdK6jfumuxQcW66c=
X-Received: by 2002:a17:907:971d:b0:bee:c13f:7ec0 with SMTP id
 a640c23a62f3a-c108c7fe9fcmr55355966b.8.1782199884534; Tue, 23 Jun 2026
 00:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619095936.24080-1-nikhilsolanke5@gmail.com>
 <8175e40d-357a-4513-b827-752f679e9904@rowland.harvard.edu>
 <CAFgddhKKuGQgu0Ahu_WRyZocQGwPZkUejjoaJQ+P8--+k=Lwkg@mail.gmail.com> <8da4a00f-a01c-4b38-82a3-a718e5588f51@rowland.harvard.edu>
In-Reply-To: <8da4a00f-a01c-4b38-82a3-a718e5588f51@rowland.harvard.edu>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Tue, 23 Jun 2026 13:01:12 +0530
X-Gm-Features: AVVi8Ceg9WedBgeSh6qEiGvuEGTJVDy2JLw21bGpVlYvaoqzbD0_RraFsYA-2-A
Message-ID: <CAFgddhLVAp7nMX4YUHoaG+Q_Hm6w1uq9df2kH+4RWiJJGYDdhw@mail.gmail.com>
Subject: Re: [PATCH] usbcore: Add quirk for 255-bytes initial config read
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stern@rowland.harvard.edu,m:linux-usb@vger.kernel.org,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:michal.pecio@gmail.com,m:stable@vger.kernel.org,m:michalpecio@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-267883-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhilsolanke5@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhilsolanke5@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE52D6B4DEE

I have a v2 patch ready with all the requested changes along with the
documentation in Documentation/admin-guide/kernel-parameters.txt. Is
there any other place where I have to write documentation?

Also, I would like to know the "low-level" type reason as to why do we
have 2 separate buffers. a desc and then a bigbuffer? Why don't we
just realloc the desc buffer? Does this have something to do with
reallocs in general?

Also (a bit more tangent), can the usb device potentially fingerprint
the host os? if we are asking for 9 bytes first and windows ask for
255, is it possible that some usb devices will fingerprint the OS
based on this, and behave differently? are there any other such places
where fingerprinting is possible? In those cases, is it theoretically
possible that this patch might fix some weird devices that "seem to
work" on windows but not on linux? I might just add this one line to
documentation that it might theoretically fix other usb devices as
well instead of it just being a quirk to fix a game controller.

Nikhil Solanke

