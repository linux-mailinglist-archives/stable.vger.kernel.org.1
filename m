Return-Path: <stable+bounces-230932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gbogBngqyWkQvgUAu9opvQ
	(envelope-from <stable+bounces-230932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:34:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F25135242B
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDB5B30028CB
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AF4378825;
	Sun, 29 Mar 2026 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLvDUb+Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E13378D76
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791276; cv=pass; b=W8sOSb8k0Nm/lQKhUrNg75xtGJ//hbNjnjjasxdAB4WLwneF9p23cn51jHBQYVniY2CAH9LOc4OPjGB+LyQxd/IBEvwAu5VnvBZ3DEANOf/IqjLsEKCN2N8S/N9BXWTJPfgXvrpAQ0LTGyZuXUUAhfSzBDpEd6BTMd+rBwDTJCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791276; c=relaxed/simple;
	bh=lc1o/OCjP1zVGo1sCgM4rVOl5NhzVGbQplXXthr45hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ML1gbKYIRI+emQxrV4vzC2FXF4dqT6/Y5DMa+xaxx884CCXZ0avW9kSxGFCLTMgaUiRoyOlBN3iib8KfhpUj/HkK3jHYMr0Zp3586UHztTkd2MwIxjy+z67K+1B0ufs3+HtPrjnwn1Z/aM0NQxH3LATIvN183zLRZi/nmTwxInY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLvDUb+Z; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso563093966b.2
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 06:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774791274; cv=none;
        d=google.com; s=arc-20240605;
        b=BmdXMHwZ8ODocBSPYbUvJCy4yFqlk7WQkNp6FpPZnYwV7lxE/OCpDScNHILa2CA/+K
         mJqEey+bIkGud5FU6rWmlAhjn6mh1Ltf/NIDzCL5/FsZPZJvYnVDbVhRRcY7u5y5L4Le
         B3nyJO6a91Sqj8cNEvEBMDWUsrsKtWMiiqaZGC1qo8yi/wWbQEXF58WIrcvnBgg8sgzo
         BDagbhx8KZsNLNb1fp12es+nc2r9TM6wU9UHHCld2b6aG7UpU1fq3EDlRwg3xCuZ5ozD
         yMCb6dKDYCVWzkxnUBnqNFCwD3wEywUv2B+JyQmkPkTmPWrgGn7eMmtYqxSf8RtX2rbP
         GNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7H7rxFJ1T0qRKjkcYGj3p7DcwGDIqc6lblsXMnGkOE=;
        fh=IvG7SUGNAoQrUq424z4dQTkJZX+6WlNj3vKTl0bXgiw=;
        b=ddJnupa4Na3R1AjLVbn3LshynQeIoMuICfOGgIBIVv/kCEtP/DjO7+Fli/TFgXQc/u
         uc5AUnyp/W0/HL4573HdNQML88g/Sq0jNKUqcZYbchq9g/2uSevw70zq6LAl7Tbr8geA
         fiDOZ5LYfk9v7QzzUdBbtWne3wsP5SCe3WErn+amSnTNCgIUq0L5RlTug9kun4Xds1yW
         mT9QLFhkFWmXgjQkxxRi8RXf5XLSzGedwOtKBDoxhUqHoSHQGEno1Y8PFO62Uqh6Q5BW
         pEWZNoLgbhJLoQGPJ0U0ehw5OQmDitQgzNDvyzKn8/ugpGUi+3z/6b1X512mJrO5WF65
         eLdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774791274; x=1775396074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7H7rxFJ1T0qRKjkcYGj3p7DcwGDIqc6lblsXMnGkOE=;
        b=kLvDUb+ZPaWGGjjmOvYq7ceQWH64soZFMCaOlh/8b+wQ3Jwfd+mCoYXYnGpphcIXJw
         OeHlPFJVYB/hV0vmx54J6shzLO4k+b9te8KsE47/uldQSoJhDPI6NZQ0R9k8qqKjLpiA
         6bkVY+90NGMPaghDmCWF4hpDSypVeYfW0FlonmA1BC32za060kieuQVGJc3oVO9lg2h4
         Zdgwwr7CQvDVv7/YPOdqX0Om2mUvvfsdWc7fvwZUA4mUu2T4H47gkmYjmx+t13fU2O9c
         dsBF8q3gZPEbJNww6xgAkQ6U8hetnLouPddmT/7aKR5xdBQ56b8OwKwgOpEK3hVrQSun
         Gnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774791274; x=1775396074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7H7rxFJ1T0qRKjkcYGj3p7DcwGDIqc6lblsXMnGkOE=;
        b=NLw6HIlPIe1kay468HPhVg/H64nX+gsD3Gf8987zEnpqd1KCqmkJzawkdYQ6J6zCK2
         f/bGnhz+xof3wjVCnZBhQlw2jPYjjET6FFOuebsKVs7jyGyeIov7oY57WE7Me/UJ+fR6
         ViK/kH0M2LIXEJwCLpJU5Y4bGPMXrMG4qxTN5eAhXUJLyetpLLcv5XhoNx3nCJ77FDv6
         34C33vq4XbIpq6B1kxRIEEezPGmfOrIUTvXZGxxq3Z1txbPIzmXPu78slF1O+0TbAD01
         lsCYdW4o3Hm4oDR+TPdV5zgBiS46Z7YOn3iBEtkqNRTXEfRUt6/CcVd4Rya432Io9elS
         Is9w==
X-Forwarded-Encrypted: i=1; AJvYcCUTxswWcUR20ptYZFL19a3nWH9C/xplJz46vKUPqtThc06rROChNFSh1RE+/spkZcb+Vp2mCwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfLbJp6bFoe1McErF+MbPcZUylPvRxdKeT726jIRr00XSyIwA
	k2p+YvLq6ASpi5IZE9RANxbtLwvihFpcUOwWWN8I+q4DBis7WRQJUaPMgEQpHn24oW04Q0Xcl3m
	qmMNFhH9ZjkPtXjUKCmcKPL/uu0z5XUU=
X-Gm-Gg: ATEYQzykEdf4fP0qz+aNd9OiL45qF0+4fG8gOCGmEhREp2ogUXrOVPMpUx7akgfL/qt
	54HifrRZl0jjzmG4ffdGbcDJdB9D1adzAcYnwCjV0gdCpw9iWvJmuPuUZBTBUTFii0UhFOiL6ng
	r1sQuHfiH3I3RLgljjvcsQGczQtjxcti6hngbEMU6Moxyag1dsdt6Xuv3/jGrLT8wOYLgAy6FY3
	yZnYbseIu3z4K37Jwpeq7XN7BBOdO+YWkcDee4SmLqmL1Rw99qk2P6pa3U5xVLGumBv5gyk2nzB
	xY7mjyWl
X-Received: by 2002:a17:907:86a0:b0:b98:27de:2e0d with SMTP id
 a640c23a62f3a-b9b5091bd23mr533174666b.46.1774791273472; Sun, 29 Mar 2026
 06:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329125437.517980-1-sebasjosue84@gmail.com> <2026032939-salt-cod-3bc2@gregkh>
In-Reply-To: <2026032939-salt-cod-3bc2@gregkh>
From: =?UTF-8?Q?Sebasti=C3=A1n_Alba?= <sebasjosue84@gmail.com>
Date: Sun, 29 Mar 2026 07:34:22 -0600
X-Gm-Features: AQROBzBrR-J6p2c9kjEnJKYFnJ2_tvFz_6dExGdFnLx8XmpRxGwErNpJNcNWZGw
Message-ID: <CAJD=UNf9Ax4oZ9YTj8rr3jDWaGsXr4bX8uh2A-EE+w49QwSUaQ@mail.gmail.com>
Subject: Re: [SECURITY] usbip: vhci: heap buffer overflow via crafted
 number_of_packets in RET_SUBMIT
To: Greg KH <gregkh@linuxfoundation.org>
Cc: security@kernel.org, shuah@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230932-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0F25135242B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg, You're right...I see the patches from Kelvin and Nathan on
linux-usb now. I should have checked lore before sending. No AI
prompt, just manual auditing starting from CVE-2016-3955, but clearly
others had the same idea this week.  Sorry for the noise, and thanks
for pointing me in the right direction. I'll check linux-usb first
next time.

El dom, 29 mar 2026 a las 7:25, Greg KH (<gregkh@linuxfoundation.org>) escr=
ibi=C3=B3:
>
> On Sun, Mar 29, 2026 at 06:53:32AM -0600, Sebastian Josue Alba Vives wrot=
e:
> > A malicious USB/IP server can send a RET_SUBMIT response with
> > number_of_packets larger than the original URB allocation, causing
> > usbip_recv_iso() and usbip_pad_iso() to write beyond
> > urb->iso_frame_desc[], overflowing the kernel heap.
>
> Ok, this is just getting funny now...
>
> What is the AI prompt that you all are using to "find" these usbip
> "security bugs"?  This is like the 3rd or 4th "report" of this in the
> past week or so.
>
> Anyway, as always, the usbip connection is considered "trusted", never
> connect to a usbip device you do not trust (on either side), and patches
> for this where invalid packets are sent are always appreciated.
>
> Note, patches for this have been sent on the linux-usb mailing list in
> the past few days, so you might want to have checked there first to be
> sure you didn't create the same thing that others have already
> submitted.
>
> thanks,
>
> greg k-h



--=20
Sebasti=C3=A1n Alba

