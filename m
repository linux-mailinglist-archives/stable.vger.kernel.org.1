Return-Path: <stable+bounces-222500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPp4FdfkpGmquwUAu9opvQ
	(envelope-from <stable+bounces-222500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 02:16:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4631D2453
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 02:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 306C03014116
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 01:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E22BCFB;
	Mon,  2 Mar 2026 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7n/RFSZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D3F4A23
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772414164; cv=pass; b=n5urTErME8YjwvHo0gojwc2lfQ7YduaWneTyom6HRyFi1+X85CHW7be30c3WbFdsdltYxp71c99Y9eTVDuQSGDhs3GqOMCRc6HFKQFPIV2PIWtrnHjkiaboxZOVe7rxAu3bl8ZHjF3H3eiDBUXtD3waeUQ6at/xMUaVtfOfu7k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772414164; c=relaxed/simple;
	bh=LYqYld5JJNR7Y+dd3q0fiVF2xhuqJ763EnML4t4kM00=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UFfNiwAPKKPTZIL8vtNnoN26Lhd9jqSKWWNUPKB6aDZCuLQVIkdTgwQuNRMKEOvaWOm975oqp0aGo8LXkBiBJKo3qHcGdrSSn/yMt30BuZDts7CxSl+0I5T9r5qT9rTKsGqDQjNXFc1upMcbvq88uxUG7LzEPVkPjWZjJaJbUDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7n/RFSZ; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2be07cafe27so22139eec.1
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 17:16:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772414162; cv=none;
        d=google.com; s=arc-20240605;
        b=V+rfeTcwuTFFeF92ZI1p7/tKc6sWS8H6C+5hXBeXV+MwPRRkmPgaMsvNz+7nPUE9Ph
         W5fU349C7e8+G1fkzgYlzdjGhIM1exwCzKHVGZRB0nq3+m34Ojn8osQgY26TBPNrBdQV
         CCyV8oK3PQNaya+ubhRhjqoWKh8jSCCsdzPE3mD/rIlxJdH/v+jQYk8ZtY5sOmnMyfyG
         JuVq+GtUlUjXDV2bTlUIyGcOj7MTBee+6cIxvNpzBSLiFdUFeuBhyCDakBzcS3X6f69M
         FkNO1le+N3djXbaHxouIboComNmsc1V+kCK8ug4EZjWT0Q92+NU5ldHrfnuu9oR6wRsW
         CPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Ag54x+BLSUfMRXYtNZC4SCt0TY1A6476YfhZrbmxKNM=;
        fh=c98oz+cWbRoaOFB5igAXzWL7ueyEcdrkA8R/oRtNQLY=;
        b=iuhUppZkq/11uIfUjzXP12vA4JQdcmCCvIkU/XmsdsRlb9i/tqWboVr60Xc6twNhA4
         Jhl8J1s9//jLuadLpqxgrlcnCEZt0aujjPWolFuRoJQ4s2XihLceMuSpndyJQ0T/x1/Q
         zw6oYKnKu0PH7dbPY8J6OPDtTcw4y7WJe/u37CTGyR+2cfVlSRGhWeqr8JlItMZU0jRb
         ZaisrFNcBn/AgjZBvRisS9MjxQS3jpUzn9jUMTpjZlw3k9AAEyUjZaC8L7UTZUun2fMS
         8+jWr3cKKjX6k8C68KqbZ1ijN3afu4F3Aez63JdIJZ2eyTU5lQ9svLCjqTjEzonM5O5D
         1Q4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772414162; x=1773018962; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ag54x+BLSUfMRXYtNZC4SCt0TY1A6476YfhZrbmxKNM=;
        b=c7n/RFSZRKJ8nx2glKVtIx5yc+IUxK6cNsUA2IkefjnByo+ZESLofm6mQIw7mHstVG
         QeHFaTSv7i9R49mKveA8w/Vt0UbHxDIW+vUx1Rl6oSE2fdXrMOd60JuVLhkSGOdhwMws
         KIxHZphoNtmIW9rajiNplcJSUvlBisaUN2CR8o+j24sRI7YTldHuZPoU15xJNHugL/wk
         q0Aaf6602CX5P4J56QjXd0VpL/0I2IGeUaNr0gQmMsbaaquczEMUQqcuHuvON+4/g8JF
         X0ZMFNfturhe2tBbh1NegHoRgmB3qIbnS0VE+cSS1K5whdcfOR4kFSyUTy1SRBv6TPvz
         560w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772414162; x=1773018962;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag54x+BLSUfMRXYtNZC4SCt0TY1A6476YfhZrbmxKNM=;
        b=Me6/JAWAvjQD4glJ5acr8Q0iryRam1QuX9RYczULuz11oGwaYJlEIR0QvjknrbgkdY
         xSLhpe7e5dwHa1yMZlzsNLDQ3H5pD49YrzvA+GQweIs7f9AVSBY/HpCL4hcZPXWE3wJQ
         o6r2nA17gtJudMQVbMa/Ra6H1l28ylj5DS5GS3PGosgG4kxVC3y9TGQNEEwD435aAbTs
         sPk7YMrI9U3jijIpCj8DytirQ1wz/nh4kKMQW3SoMmDsTFOr1FK/+abbD+eUBnXSaL2j
         BB/ChTAglirDHYJGq4mbZ+FVXlzoEHGkdYcQG/67jvYfe63p4gkOPP+pwMObxSYcv9Xq
         Qwew==
X-Forwarded-Encrypted: i=1; AJvYcCXSx7KaUPoZQyREEh8nvBfsHvuGyaYkd9AvEXg2Ge5ew55PQru8C7lGyObXA5bb/Kra54gfT3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAs6eHDXYerch+Qu8QW1UR5pgVeZnpHD36WcKmKtqNFYg+eDq
	nJRyg9T9UjQy9bRsJN1vOnypEIMQd27LMeLQTU0ogzOTlcfYBwh8zO8/6FqA9jTD1vcJBos5V36
	5o7p5FJcNuch09ZDMoPMoNsyBG2dOu2o=
X-Gm-Gg: ATEYQzz2qIKx5xwIhjqOVmaFQ+oTrLMN4w+VTV+M4T3lmEEKq1ncAV+eU6ONZ+Z8/7G
	yBjmcv6ueQH9BN0iUMo7LjbHEXO4zQ5ts3ncMCfQpeitD7NgyKihTtAzIvtTGz28lDQ6EKaRI5U
	BsM/1LGzMkstcqOE+Hz1j/cvDrIuyN9MaLOTG5RaGLjXpqeOrOhpZ6OS3AOPOj5tJenTVPPns2i
	yDUOclWnmvNk+cI4peOnLCPxYj3kSNhwKhfVSxOABcAmYU6n2o6+3n+/5bzJgxK+bRM5VGf6mek
	f/GrfrErTr15URWQIwUouMoP6An0iPWQ4xCw8/AN5Mc2lYZV16iHCcmwJdL+U7wUNZ+126u7vAs
	MLiJrgK3otUvo4r77Ev67YY3yuThayEgxoFWIIqw=
X-Received: by 2002:a05:7300:6412:b0:2bd:d111:cf18 with SMTP id
 5a478bee46e88-2bde1e87317mr1868758eec.8.1772414161758; Sun, 01 Mar 2026
 17:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Mar 2026 02:15:49 +0100
X-Gm-Features: AaiRm52d0xAr7FLEdwWAVZQ0SvYAAQB6T1cHf3dbWP8uV1UsR_xpbJJXtBiCCac
Message-ID: <CANiq72mESZc2RfL2_5wt=LEg6M_7TZ__uELZ2tN=XGwB5Md_vg@mail.gmail.com>
Subject: Consider applying patch to 6.12.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222500-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AF4631D2453
X-Rspamd-Action: no action

Hi Greg, Sasha,

Sending this separately in case you don't track all replies to the
`FAILED:` messages:

  https://lore.kernel.org/rust-for-linux/CANiq72nHESphKjW7uXm2D7HCNWNxmZ3nv+CSgrzEGgSKZ4_taA@mail.gmail.com/

I am not sure why the patch failed to apply -- I would like to
understand what happened there, in case I am missing something. I
suspect something odd happened, since other of those `FAILED:`
messages were strange too, i.e. most of them didn't seem to apply the
`# ...` instructions, which is why most failed.

But at least for that particular one, the patch should still be
applied and it should have been cherry-pickable as far as I can tell:

  0a9be83e57de ("rust: kbuild: pass `-Zunstable-options` for Rust 1.95.0")

So if you cannot apply it, please let me know!

Thanks!

Cheers,
Miguel

