Return-Path: <stable+bounces-243028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMPRNxKX+GknwwIAu9opvQ
	(envelope-from <stable+bounces-243028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:54:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 468954BD45E
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E97793020D55
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926AB3D7D6D;
	Mon,  4 May 2026 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtHUDAbQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4003C456D
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899256; cv=pass; b=ZZVmsTg3UCCc9bC89nUjzgAq6gKYuhObtu48k5zbZdlzR/+cWbULsxZYK0gJBhF/J2DM8dGzJ3iya5AAtx6vkeIHRUlf1lKlwK/eaoVLl+TB71uxbHQ9nDN+WjtbQd8gLJmmk5ioXZ9XFPuy4Db3HW67qysYGK9oykQgL0ASXRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899256; c=relaxed/simple;
	bh=v6JgnDVheM6AQTmrvpp8XRzGDsaqQOMw3Z6r1k2vb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hcth+k/R+m+Mxz5/+d1UehWx4YxWK9EFWIhATtBCVKQhAB8iEYJ6En3xfivb1MG0OZ9+h7dbDjk5bclr6w+/yP8coQAMtBl5LHcqeuwO5uDSFvn7xWtKEld68+11/HGED7mjJsIHs4Vujs42Dv+abmu5Tf0oCa4TeC+e+sZ8RLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtHUDAbQ; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c0bda7f15so3929054d50.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 05:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777899254; cv=none;
        d=google.com; s=arc-20240605;
        b=gU92K8sbcuOncn4mMWxQRc5rbquSSlLrWPIE9cdvhu8kU7rqUx5+2xx/aBQr5SrCi0
         ITdXBbOWN4GeXVUlvKdKOTRUDDrP680oJt/0EJO/rMDRJYgHgacG/YurAf/acoUAMymU
         Uw4btuIwjOQb1DXaSS3aSGXT2MNUIwFoHz3vHzhlXd7ov8velXLnZ69Vo12zeHrsIenn
         keAOGWYcC/PMzQye+GIL/yssNzCioaFUqSs6Ry5QEogB3Mw1xhs8a6dzfX7TeSX2MILV
         teISiqV/6HOhRmfekoL+HNt048uN5lTrSZR3zk2cM3r++LT/tf/Ii45AhNEahNZnx4cf
         X/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qABVt6vtDKOBUqxbTW39Jms/G+sDJzuGpeInjnzgdw4=;
        fh=fvKmjD7Lf+yT59fmWVrHYBdaS7URqSOoslWMLof3+gA=;
        b=L0eWBnLy/LatPKU9j1I6ABYk/yjCZnu92fC8sXjhvDHMFZJKU1Qwk2i1RHXUSnFaX9
         7DoseEkdUlC1MhxqKMYKj64ryE9g2jZ50rYOGgIyHsXCysaLCHpuINmSDmLF7Na5/tb3
         tZwtp9FbkHd7ceFGIx6wOK/yc4qZf3ZyFYeotCQiCEb0D+ASQlb5Css1omYTxHhdXz+8
         rEDeMRjt9PRj3tP0kAOhqjEuqxyWexPgcyM2wOg8tm7lq5uTaGniWbQRq+Y3jcUXpiGZ
         qKx2SnGS7dpqWQJ5U6wJQ8tgOcvsLtUxL2cOtjAIS6CzSUd1BmGzPWkazlsaK0uRJvvl
         c1Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777899254; x=1778504054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qABVt6vtDKOBUqxbTW39Jms/G+sDJzuGpeInjnzgdw4=;
        b=TtHUDAbQIFt4BYSHfZxvpa6/hZb9dUsHLOuVFyI0geUj5hx8mWpKsuU2PzKy9x2+VS
         kHjZn8m56DVsnuGr8x2LgPRy0sek5B6nuSIK/Srz9XsS2raYebCDFQr7hJP+WJ1jnD8s
         ve8nytJuzPWD+eCmDmx1HPKa8u+Mcinv4i4MK/ilhHGyB1y6V3Mh0r5ssd7ye8T6NLHA
         aWg+a5PAT3xeH+DE8IwrEhHVEDKWAtHgRtQtSLNxndZd1COsZeOdUn1otbmgiVJl8tws
         HRTW5WVyOThoQMmWL1215C4/jpgAKHgoSf8bmwVZOiKXAVf/5chtY4LAP/QFPTbV8b9L
         Iktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777899254; x=1778504054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qABVt6vtDKOBUqxbTW39Jms/G+sDJzuGpeInjnzgdw4=;
        b=JhGtAgOd0MOlC7rqHZNbKIx+9bpFzqE2xvjAhcLbW3rxQr/9uk+weysyZ+DZ5hgkEY
         kL/yyvXfKGQG99yyxwB/GzDASjUiCf3VxtOitImyZSx7wf6LQy4rza7kMVPxAiiQp3bC
         +m8z23wpazdVNoCxhS8Z34lv8gtURl+c9nhr0MH5kGknoaVcbYetgnwTkaypqHiKHpt9
         QM8RXPf1Om3DDeA9oK6EwtBt/symHqaB+YJgm9j84Aw+OC6N5xyq8TfNPgfkvFn981q4
         LqolDTiwClEbyXV0ZaZTB5uPe31H6mRRrcZRakQvyNnbhkkiHKdJC6nZLxAhRRUIdJAT
         wWZw==
X-Forwarded-Encrypted: i=1; AFNElJ9UH0VQteiRS+/pVmt+rsxczGCgf+ZZkF5cvgq7sm0Hhd/ys9lYMgElkutW5wJWk6tbRQtXVEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4tTPZwDMZudaGzznlgtGxAXpommH3xgjwy1+5a6Uezl9Ub4Q
	qf7/7rCU8h49NKu1qRi7XYCN+U4JzFwsHHfJRwW6qsZswRHR8EUAaMREPFDU74OS6AosgcnCqMm
	X8qpEbcH4gxXxMLE1+oFdWph3sOp8M+U=
X-Gm-Gg: AeBDietzDSOfkLfdOM3rM2K9s1IZMHv8SxZNUX0DhmAr7dIRlbGjv5+Ldm94M+f8jCF
	IR5rLe7V/sXIn1NQ3+VVUuAgh5/vHFxamqBX7n5vnJleJ3sfuyIIZle4AZ/xz6O/fYkg2kaw+go
	HvVounCbXIveFU0dRVj4p9NDmTOdDXF7Erau3G4eV69SOn9k4JyLZyj/MDTnOHJl2Zlnm/7lySj
	t2BBv4rcw5aaknO2KjYSYieKkoSxzABBuIDGGM7ljjgSEYimSb5ulj1HRbURPCzfUTm0azS/eyI
	tZ61A4LGtikY1WxSdhqBBBMtiuh5mY+uSaqwrc3TL+e3Ki8=
X-Received: by 2002:a05:690e:bcc:b0:65c:bfe:80ed with SMTP id
 956f58d0204a3-65c3da6941bmr9169022d50.27.1777899253774; Mon, 04 May 2026
 05:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415123221.225149-1-michael.bommarito@gmail.com>
 <cover.1777817011.git.michael.bommarito@gmail.com> <ce8ca06ea5f7a9aa1bf4a82a5aa764b22256f908.1777817011.git.michael.bommarito@gmail.com>
 <afhgWlu2qiwqSLUQ@ashevche-desk.local>
In-Reply-To: <afhgWlu2qiwqSLUQ@ashevche-desk.local>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 4 May 2026 08:54:01 -0400
X-Gm-Features: AVHnY4Ll85MvdMTZNu8G1pXg5DkL8KGUgGScYRuhsS7hrSy6LP10qWPEVFK5IBM
Message-ID: <CAJJ9bXwkJ=LZZuenHaSQKXpy=y-uE1vUrrwdX4LE6ON-kF2xrg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] thunderbolt: property: cap recursion depth in __tb_property_parse_dir()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-usb@vger.kernel.org, 
	Andreas Noever <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Michael Jamet <michael.jamet@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 468954BD45E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243028-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,intel.com,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]

On Mon, May 4, 2026 at 5:01=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> I would leave this on a single line (yes, slightly longer than 80 charact=
ers).

Sounds good.  I'll give it another ~day for anyone else (like Mika) to
weigh in, then send a v4 with your updates on 1/2/3

