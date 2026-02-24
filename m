Return-Path: <stable+bounces-217870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPPtI1FUnWk2OgQAu9opvQ
	(envelope-from <stable+bounces-217870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:33:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92D2183111
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 875E4301B721
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF68C33AD94;
	Tue, 24 Feb 2026 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOxpnb9D"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E321ABAA
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918315; cv=pass; b=e9vkO7O9V3n39zyP+3d4080zAip/CDz7A/at6YGBUY1alsuqzxgu0spBqsIK39HhzNGtP9CWBdOTt+DTAcKJr7BOWEvaAWjeQzJx9K+ZrE8qk3+3vFkzMHRkpKVbnCz8u5RVZyNi0fUbW/JaXbzg1mX5zMvq24D7+A/k3hWNS7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918315; c=relaxed/simple;
	bh=z43Cp/+0b+DQ/UmystyDX/o54828M+JOLwEhgYAzil0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qc7QzJlqVY8EJqBDdSK1NQXDfgYLq66HZ3WQ7QM691VwUFWnjyAKVf2BRHhe4R9ICJ1T+nSIAkooPLYc+g5/El5RgCWPmGcT6OnpRAJGUHN0W3LfYQC4fI9zVl7Fy+9iK1Y2Ik1QTbGS4Dxe/rCIjO/Hl3Ej+/MWlgWG0u/uvgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOxpnb9D; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1271257ae53so4883731c88.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:31:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771918313; cv=none;
        d=google.com; s=arc-20240605;
        b=cXtLTDkQCP6LGM9sj+aCu1oqtbhFXt+ZS1nREpsuDygLbu+qnmF5HnJkfZWM8Nu1qc
         MasgT7B0+RCkpSMDmyyn4NvXXpRYvBP48ds0sKRofqpSM4yG3hm6vnstHQAN65/7hWRX
         9Y5GcmyEcG/QkCrJycY5QHkTwy4tZ1+NX9vVJQUb88S0q80ytWE+0Tf+7msCtu3hcRRI
         LU6KnTf1jSafhD7dTYlXIjWY0HcyweeYsyd5ldcQ+ADs6zstpi+63HwVITqbmSMfWuNt
         HrUk6/sW6XWZzMYkW36My79TP+/XP+9zSrBS8O+D+9XUkkHcFr9Qia9FKBrwXTuDKVaG
         CSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P7O5brEuc4hHOUqgF7dos1OUBEpYGd7q0nwtKnTvzkg=;
        fh=iKkeKbJxw9CBmTT8ZzX6fsDftNSlJfJZKA3iiatzzSI=;
        b=VxI28Vq5fhW+UO36H8MCWm4qcFIh/35nARWVb11P/CirBksiznjCpz63EhDm9sm/ze
         1x4VsVoyCoVGUZa5pIlxWlX9Mp+kyMkOMEIT7HfCyccZq+OMah2xc92KeewEd2EoCGDm
         5eOFY1F1LJU1HcpXC5HTHXJDZFuW/SDQ1/VsBtrtBAhxmPDu0zkGQ6Gaa48Qd4G9hAXJ
         fTqx46R53tdX478FGdZjTLxHXuGHd9ECqy9CVGJS8ReLjv9OHy/qihrUKY/tGACF60S9
         tO8Fl2q0UHfG2G8lFV1gJIkqpd+ENLvX5xKHbrKAyT7LRfmf+I2LvSG7BzYlh6zLsgyi
         s88Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771918313; x=1772523113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7O5brEuc4hHOUqgF7dos1OUBEpYGd7q0nwtKnTvzkg=;
        b=aOxpnb9D7esJI5Rrz3rf8MSQV137M0FnCoUiVci2bhxlaOHsaoCtC6LIImHXBTOm1l
         XS4II5dW2lkAOJnDd0kUPARRpL1j/PQIQduVL+FuLa41fGQcvq0v+jEz++/ti1MmsJz4
         MhhKfCtZMTslkNC0Kvj5Re4CufddZtapVjmFTE26p41gIuR8boDS07IZDFdvAGupGh3z
         biScGqxXyKkE4kbg7gL3WIR/n54789se9Y1Aka6rB0rfYDzpSx/cQLN19pue5fS6CggP
         4Y3ILe0x2Han4Uzm6OjekRSQASGv6K3UcUyKLEgJ6ZWHoBB5KN+HVONK+le0kDRpzQ+8
         h+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918313; x=1772523113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P7O5brEuc4hHOUqgF7dos1OUBEpYGd7q0nwtKnTvzkg=;
        b=hxLcJhI2RgXt+dWz+GVHioFJq3s6A8NA8xEH8C/wQHrkzYTSV0I1y3BrNSuudn3oNx
         ZvJL9GXMEYhDJKzTSC+GuO/wbjex+tzd01eSj9WR7pFpaD/7FziyPL6gNjV0SxR2gRzk
         s/9lnuFm2FICwKqhpniIeq6NIeTguiSnA4DxRMybB2dlcHptS1IbJS6jcFdoKepmXy5b
         K8UqO3SEEMEglW3YPeWTxGE99EC3w7EwEyVHqpTePJr7Je5QebqXx8QUA99gWrTQTPIg
         G/bme9Kx4nyqthK5jZRC5yvlMI18F2N6S1CVsN5g+M2HRqTXtoNo2tE6b3Fx2z2+ZDq0
         5b3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0unfuHjimZEZz4IGvLKEAYXQjaZDNpIeJE+1nXlPgGIR8ADzbBpHLtVEAtrA6UUY1cDb86HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMEggIWpeHbBtpNSBukTyws9Iz/sfMQeUndq71yYvDuDRkurq
	VjYiFWPJryzZXystxHcxvJkGMiwYXHb7VQ70VZ0/li5PxtOnyEmhck++D/bhVIZD5E8/5AKREj5
	9BaavRnjAAWq4udpqGDkPM2nONbhZEQM=
X-Gm-Gg: AZuq6aLSUs4Tcc2zb1DeZJcLQ6FAQnokV8YpM5UUHtFAgGnVRE/Xh7nqYboqydSt0kS
	BFwojaD8wP5Fc/1OXbYPDQOWwQhEV6Y3AVBF00+3S7AqYVO+jCkSCTBK8wmopmyBhlqO0yrXq8d
	u5CT6blsHNACGloURfSz8+3KTF5b1GIPXuJ77N+gXeMC9S2NV1lcLJs42dr5YrCgVbkFN4PGzhu
	TwyJHegWoUxsEQ2R6UhNVB12ht2F1H532cyy75ClvYmFUqSLhGtaoQnTPMwlmR59DbVSeg7Ksbz
	WOEPz2ma5wOxRu6M
X-Received: by 2002:a05:7022:2383:b0:11b:9d52:9102 with SMTP id
 a92af1059eb24-1276acb1c8cmr5486833c88.6.1771918313381; Mon, 23 Feb 2026
 23:31:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OS7PR01MB136024C7662EB4DEC04ABC648BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
In-Reply-To: <OS7PR01MB136024C7662EB4DEC04ABC648BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 24 Feb 2026 08:31:40 +0100
X-Gm-Features: AaiRm50v7zX3ShhjxV09DUlZf9T9Gg4X06P-eS7knGjPR37Dt2Jm4TGUUT0baIA
Message-ID: <CAMhs-H_7O-751=gypxHUUdBp01E4HqqWYVh2GUJO32wixQiUyw@mail.gmail.com>
Subject: Re: [PATCH] mips: ralink: update CPU clock index
To: Shiji Yang <yangshiji66@outlook.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Crispin <john@phrozen.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, stable@vger.kernel.org, 
	Mieczyslaw Nalewaj <namiltd@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217870-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,phrozen.org,alpha.franken.de,yahoo.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergioparacuellos@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,outlook.com:email]
X-Rspamd-Queue-Id: E92D2183111
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 3:23=E2=80=AFAM Shiji Yang <yangshiji66@outlook.com=
> wrote:
>
> Update CPU clock index to match the clock driver changes.
>
> Fixes: d34db686a3d7 ("clk: ralink: mtmips: fix clocks probe order in olde=
st ralink SoCs")
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  arch/mips/ralink/clk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

