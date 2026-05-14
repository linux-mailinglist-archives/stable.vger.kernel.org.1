Return-Path: <stable+bounces-247076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANMbB+0eBWopSwIAu9opvQ
	(envelope-from <stable+bounces-247076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:01:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B153C820
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA8903045222
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B36830149F;
	Thu, 14 May 2026 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtSUalGF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C42F9D89
	for <stable@vger.kernel.org>; Thu, 14 May 2026 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720483; cv=none; b=RBx27ENUfMVJR0M1vU2R6NUHWqILR9AgDRSoU3FsXP5nMJ21ZmrDGVNKkdI8H5NugVYw+VS1DLYFoNz0YFpwVkZRFxUiSjxIITqU2BLMmW6/dQL0zrTfIDMJttL3Ked9yP5blK0eMhP0mKuL64tI9dWVmmOtAxUPA7tB3IRRue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720483; c=relaxed/simple;
	bh=NbKYeMkM5NguN09KkOFfqTgmRSOZdoHYNf89lOAIJxs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cf6RyJuCIgs4DQmJldUb91h4S4YJpMPt58UYN21oMHIKaoL+hJuKDjxe/asm2ORPAPN2D4HPZO5T8cQaNsgEd0MQRuvzvZtRM627gZC1SZrOFv1EiidylHCdSjURm8A5wzTeXQ53s7dKfEv9MjaodH+eLIAAsflKEbr6en4iX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtSUalGF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b941cd869cso47107365ad.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 18:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778720481; x=1779325281; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wuQ5LwedAkHBzdU2pK2avP+JBelQMIXLc0TXPSN3NU=;
        b=AtSUalGF6HKT4+eO7+Uzv6lI/zfGGH39C1aVBWNwVM6K5Q14UWhY/PRoy7kh/mAX1B
         UvfW2tZ3ZK3ZZuVL0pjiQijh7v4KVrqHGSUUHnQhZMAYfxe4GpNXYTEpO+/gTHzVTzTZ
         bHV9zQ8JFNp+v+53UFiuwjtdvNU6sG7jRaCepgO0h+Mco+iM/ucqM86vUONqoIZTH9CM
         6pWhaeQK8GvGQRI4D2frknK5F+vrWStCWkXmvA6lRcH6wrU41TQzQOSP1CyP1DMP6zW6
         Dl6U5yTTfDveTu+G3wqUfklBnELRM2VzC7AuPoqOyKxtE9BCLQ+JGDLvThfq2OQ98W6U
         duJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778720481; x=1779325281;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wuQ5LwedAkHBzdU2pK2avP+JBelQMIXLc0TXPSN3NU=;
        b=WP6LUzo7Ilp8jwf7/6Dc/Ms/uQjC3bo2cSKbujzBh+vssmpT0BLwuexlu38Ai5iXLZ
         MW2RNEUEtEMJM23AlmLg9AS16/PsD51jzLtXL4dfkgxcSOeHcqLQHAK4byY2y5/B5n6B
         XDmh+lGbZ/HVGjXjJ7WOHncA/IVpywsI/rfXIy567F6b9c/pI5yDcEFSZqaZOCUF6IfD
         V5xS7lCNKHxYjrp731G5Ggzqz+uqnvhPS5AH7OCwnQbtELMsvnEjofpJGxKR1xLpuCa9
         mkg3TI21k2mY16kkvZ5afZxp0YjzlgJgKG1Yf9OOET+kWNPBB5ez/Hml8Kuks+iGiycV
         9AKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oOZVzptBT/OXpU7300G08TimomU4L55i8StsAoQqwkc9l/Rq846+uOp8rtbAytznA1jjA2hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxcagbIbvMpAvLXiD+O82vVGX4DhfGQMtg/RZ9ctyZ+ziZdVr
	XAmMVGKQUU4MgAziN/wG40PSFWnQa1AgjaQXJAWPUhsqmJi2Uy3T6dYt
X-Gm-Gg: Acq92OG3aKgpKMq+0ia+/4pQu0Je6ecKws6gF9Vs5/McCNKgpZhd+aUOB04jG9+TlFR
	CeqLui19C7UdmlkGXk/6fM/B0QAP06icEm7d9Wt/KRTzHC21XcTLVQ9djonWl2h2wOKR905exCA
	g1N4c3M7tayY9gjii318lgOAG3jmZL+d7ByN8f3S9IZ5egvutNPCvCnWSgfNvUS556Jha6GGAaz
	YYklP3RUQz75gXPRC/wCbbW3I1MVzETlEGAL9jU3nyBl0qmQLOIbZKITE391YkMLfs8Fp7qiI6O
	4q5Q3puvduDt5PFWZ49FVmYwGz0ogbWLpPjp2302q3LF3IC7GDtv9qjc/Vott6X0rX9X0A/+JSS
	Frts6wKFvbcIo/EWuPqhircgYurOM7aTHBUbU1vssgUQDRFrr7tD4MPmFmmhYcGG0BTzMaevg4a
	/F/qGw514ozYJSnwq33GiXBn01Vu+rRYGidV16
X-Received: by 2002:a17:902:ea0e:b0:2bc:ac76:c1cf with SMTP id d9443c01a7336-2bd2fe21d31mr52498435ad.24.1778720481118;
        Wed, 13 May 2026 18:01:21 -0700 (PDT)
Received: from [127.0.1.1] ([203.99.159.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fbc05sm4645895ad.57.2026.05.13.18.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 18:01:20 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] iio: light: veml6030: fix channel type for events
 and remove unused read
Date: Thu, 14 May 2026 14:01:10 +1300
Message-Id: <20260514-veml6030-fixes-v2-0-abdd5837be50@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANYeBWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDU0MT3bLU3BwzA2MD3bTMitRi3aREE+Nk42RzIwtTcyWgpoKiVLAEUE9
 0bG0tAP3bmQxgAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778720474; l=1937;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=NbKYeMkM5NguN09KkOFfqTgmRSOZdoHYNf89lOAIJxs=;
 b=A75f/7N/g7XYIsoGd3lKvTwGkRrCG4ZcjYc7Mj0Ue8hfjtcs7GrYt/tlwqP+NbkG3q4h2j/tl
 ZThnAmCNUx8DeMmld/prRxRhv4yoEaGAl9DaC5xUFZYVEZ7rHauUa/d
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=
X-Rspamd-Queue-Id: 6B4B153C820
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-247076-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,analog.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javiercarrascocruz@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,huawei.com:email]
X-Rspamd-Action: no action

This series fixes a current bug that leads to pushing events with the
wrong channel type (IIO_INTENSITY instead of IIO_LIGHT, the latter being
the configured channel for events), and also removes an unnecessary read
operation when setting a new scale.

This series has been tested on real HW (veml6030) with positive results.

V1 of this new series is V2 of the one I recently sent to provide a new
driver for the veml6031x00 family, and additionally fix these issues.
As the driver will be split to ease the review, it will take some
time until I send V3, and they are actually independent matters,
I have moved these 2 simpler patches to this separate series, keeping V2
(where these 2 patches were sent for the first time) as the common
ancestor. I have provided a link to it at the end of this cover letter.

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rishi Gupta <gupt21@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Changes in v2:
- Add fixes tag to the bug fix in [1/2].
- Remove Fixes tag for [2/2] as it does not fix a bug.
- Fix indentation in [1/2].
- Link to v1: https://lore.kernel.org/r/20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com

---
Javier Carrasco (2):
      iio: light: veml6030: fix channel type when pushing events
      iio: light: veml6030: remove unnecessary read of IT index

 drivers/iio/light/veml6030.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260514-veml6030-fixes-ba43c3c72857

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


