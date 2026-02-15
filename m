Return-Path: <stable+bounces-216612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIvwMSbUkWnpnAEAu9opvQ
	(envelope-from <stable+bounces-216612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 15:11:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E37A13ECE6
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 15:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C679300D319
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD12E2DF155;
	Sun, 15 Feb 2026 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6VG1AAL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995041A3029
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771164705; cv=pass; b=Dn9YonR6Lhmtt/VBH6fqic/izFrcuyK2IxS7os0gAnTyxeY27pB/jGtKvpc79oCUWQDwTRk+l0gZQszEjNTzyy86G1Z0hffr7QGtGmaLU5kDewcUHFhYRx3ttOo2j/7mATrdf4VhVjKK0QH02nvaRnjw61MLAymHtDm6qaSlvfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771164705; c=relaxed/simple;
	bh=IS67sc4Ha9dtdSU+DoGA1J2xownlpl0HA1i2nBo07Do=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iDjjHvQmYFvFr8ZYwZYfWrC9wwbTkzfmj5Gc7ppEcUGc6HbUPG0KrXfmJlIigFcJ5WoPnk5rDZxWPOUPo1EkiFHq/INf0EG1TcfFp9u02rqTuzv4PHlrwPw+5+x9Fv/ImzEa++OoK7d2lfOiIonZ1NB/f4a1SBrMa3FX2hoP7SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6VG1AAL; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2baacadad3eso96744eec.2
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 06:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771164704; cv=none;
        d=google.com; s=arc-20240605;
        b=bLVf8N8xSP7IZ+R2se+dKwOR/ErBQYtFXqsPTCB1YvS7/RSprwWsppVx++7hbRzKuN
         CdELFdJwF1uRw9eST/QBs8eR2IlwhE4DL6WnWWUW9efg9EHCDrr7UOgQO54U8vfm2ArA
         P340IF4ePGvy6mV9F59l6DE1fDAbc+zfAd5zIUznuWTZoFPBcbA/yOJlayFqZnnRfIHM
         FVAp86AyR/1tKJyb0tiyTI3dI6Kb+FYhUeSf8XRJ3q80dSYl6YyZPIwqU/6R+7MitPsy
         IOpCI1+tZEURFPjAYxaYD+L4rbrSRwmsBBrMnd9FscDoPkAEdQlW9K/2YLeWW2f6xWq7
         TrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lmAu+Za+Ffpbk5WZHW0bF6Gwlmx16jAYsYG2pCm96Tk=;
        fh=LCYLlxsZ/HspS3ogAVzZzymBBDtcepSBqE08Mo+go8Y=;
        b=Iw6+4pMuX2mQUBJvPKtu/Pm3T/kGU7xQLQfE5wtnY+XYKuG467Nq7VQkGCNgDarZq4
         RtMvg0RgqC630fU2lzO9W+7/KRecizBNOjVoEUZjeubMckC8Tqi/G0BVOwB7CvDxVpTI
         C5BDVTAnXObybzdNJ08BdTFLMEBUaJQWcjlLY7o5pQgNFPYELc2S+eSoSMG1pKkLRT7z
         6YgVWJREBWCF7vrI9cGd3XQemKLopP06f7HBjG4Iswk1bRFkMMvqWncVA/pmArcsz4/z
         w94xWIVCoeZRq7oJUEHcPMpt3vCa7LPiQ5EiGZBog25MU8ZL4D7OCKKz+5QOo+e4Hv5L
         kmEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771164704; x=1771769504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lmAu+Za+Ffpbk5WZHW0bF6Gwlmx16jAYsYG2pCm96Tk=;
        b=V6VG1AAL/WR0gifhVmdJpLYLkwCMeAM1l5parGTPYr2nLFFpCIE/a8AIMC38McGez3
         iRsufDna4Ypab/2gw5qgA+FNHVvIQfleUCxIwTx8shSTYTGYUNs7LG1vUAglyEg6HyuH
         xh11EttFv5sbj20frQ6uUuDfujLDicmD0rCej5/x6RFvNLvvUB7Vp//5iYs/XyzZzoOB
         BRlr5RwuXG7DCuSS+hbyy3wEmlF/4b8Cgo3ogtqcLHxn5u3MQpPH7QAPPyJM+zWJC5PW
         qkPp5EBlkvrsNj54Ujps/jRe+GgpMy7ZjfN8whbtzN8mZw0ooFEyjSqGHKLDQrsRbhGL
         KewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771164704; x=1771769504;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmAu+Za+Ffpbk5WZHW0bF6Gwlmx16jAYsYG2pCm96Tk=;
        b=tte4dxTcINPCw3jybXkoySiWexC0FOHw4bz70SMnLnRNu0qj/JG/gdaujIx/VhCxyY
         6jI+A/HZFTwzJHUIYmY3Y4ra8ozFXKPRlhQbOUGdCly/3Ktk9s2J+N1w9Sf/5XMnKuQU
         O4sQ0isQ6yXKk9hnLzOa8swiAYxraO9iju4rHivWRyJ6XFmoJ7fxXeBHct6a42xHPLct
         CuDJFNIkCeZo41ZWvjiAkmjXma1rjTDFe2Mj2t4unIGrdynYCDS/sHPSjiguGGM8kBQ2
         V5EsAXz4ZoSC2QhGEF1Y8G8aGZtxse25GFrJLpK+nI9BqIGqOnOdcWsDB+GGYPGLYFXJ
         SqZw==
X-Gm-Message-State: AOJu0YwIxu031vHZ7KLm1EU6kscKtxSXnNRy3lSKHZeo8TNzd8DO51Pr
	VUQxjQ7K5HibfAU68u/TE2bOv1+T/j6adLnBK+xiqoYQoR7342HnM3hwidpuabguULaxF8BL3xt
	oolH8d9MVp9UCbbL599XCjtzy7vatNw0=
X-Gm-Gg: AZuq6aLIeuPIRWj6I6o/iiYsOewOkhX8zMPg6KGPgQybnDXp1AVJpXh0TkGX4gMV6N9
	g1Xg4Iz0k4FtZ3XuK9H0Iemfk6EXqWquwm2FxLwSg7905cXHI8QyUdVHFlFiDWdtZ8gqYcF4ki2
	+iswn2HH+txUmN4dpFHbrnsvkmK4nbkDJvr32+ill7NRGD158RtO0/M2a3JOmmDvwX0WPBTCTK9
	qtGtrcr0UDFBWBRz/S8LKIv2CIa9owZGcKjFNrNWctCBB0f3yXpG1x8f1BEBb4747h8+i4qHf3H
	rAoIPuYG3kEF4AC+MnnSu+dSMiP+Rwsze7NhzWyxmxcVpJJRpoNsreaKgSkUpNjekY5CD1vndPq
	NxJpHTMZXyBkMvVawwPq8Ir5S
X-Received: by 2002:a05:7300:bc0e:b0:2ba:b16f:8092 with SMTP id
 5a478bee46e88-2bab9ec5ef6mr1638797eec.0.1771164703649; Sun, 15 Feb 2026
 06:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Feb 2026 15:11:31 +0100
X-Gm-Features: AaiRm51kWsntpYAMki_wBOn4FdlRNmJALQ-XrmQQ5z16DZEm77O5QapQ1SrWrNI
Message-ID: <CANiq72n3qPsoy2u1KxfyV4ZCjJyDZLkK-54i7EesTH=TE9h1jw@mail.gmail.com>
Subject: Consider backporting rustdoc fixes for 6.18.y
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	David Gow <davidgow@google.com>
Cc: stable@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216612-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,arm.com,collabora.com,google.com,lists.linux.dev];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E37A13ECE6
X-Rspamd-Action: no action

Hi Greg, Sasha, David,

I have been seeing these warnings (errors with `WERROR=y`) in stable
6.18 UML + Rust on the `rustdoc` target [1].

Unless David (who works around UML + Rust) or the different
maintainers (Cc'd) have a concern, please consider backporting:

  a9a42f0754b6 ("rust: device: fix broken intra-doc links")
  32cb3840386f ("rust: dma: fix broken intra-doc links")
  4c9f6a782f60 ("rust: driver: fix broken intra-doc links to example
driver types")

They had Fixes tags, but not Cc: stable tags.

I hope that helps & thanks!

Cheers,
Miguel

[1]

    error: unresolved link to `kernel::pci::Device`
       --> rust/kernel/device.rs:158:22
        |
    158 | /// [`pci::Device`]: kernel::pci::Device
        |                      ^^^^^^^^^^^^^^^^^^^ no item named `pci`
in module `kernel`
        |
        = note: `-D rustdoc::broken-intra-doc-links` implied by `-D warnings`
        = help: to override `-D warnings` add
`#[allow(rustdoc::broken_intra_doc_links)]`

    error: unresolved link to `::kernel::pci::Device`
      --> rust/kernel/dma.rs:29:70
       |
    29 | /// where the underlying bus is DMA capable, such as
[`pci::Device`](::kernel::pci::Device) or
       |
       ^^^^^^^^^^^^^^^^^^^^^ no item named `pci` in module `kernel`

    error: unresolved link to `kernel::auxiliary::Driver`
      --> rust/kernel/driver.rs:82:28
       |
    82 | //! [`auxiliary::Driver`]: kernel::auxiliary::Driver
       |                            ^^^^^^^^^^^^^^^^^^^^^^^^^ no item
named `auxiliary` in module `kernel`

    error: unresolved link to `kernel::pci::Driver`
      --> rust/kernel/driver.rs:90:22
       |
    90 | //! [`pci::Driver`]: kernel::pci::Driver
       |                      ^^^^^^^^^^^^^^^^^^^ no item named `pci`
in module `kernel`

