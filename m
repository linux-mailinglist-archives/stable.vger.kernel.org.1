Return-Path: <stable+bounces-192273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5BC2DC79
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 20:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D58B3BC7D1
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76331FDE31;
	Mon,  3 Nov 2025 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7RcTaat"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30425184540
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196526; cv=none; b=MGVg7vi84SsDhSAsq6NkRPUsP8sCA1TYk00Zb+EFG6blkNrXZNm20wrW/RMWWGfeqabunB09ZQbefmLl6+7g9oqWzXin25vM5kMiV4LCWBaEeLO7RpLMncBeXfk6VJ6ZRX5HZns5+meEaloG/F4EGV1XaqVGm8bj8mcq7/4HMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196526; c=relaxed/simple;
	bh=DbFAwez0cjMr7osbfexuB3kDFZnSvUx7kQxtUW3PIsc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JurunK2R6s1mJqluwDGzWyOOF4Wa26g72AVORBz/hmJQV4JBd5JG3jgzTdLiC23Bv1dENcglaLfdNyKxCZFMot3ZeSIE+ssG5mqieNmhOjWvfUSnVtPUpwurgtx5Ey7pJC2/U3zaj/Lql0Svfxo34WtEI/WSwLoIzNcxYbIiYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7RcTaat; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93516b64d04so2445398241.2
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 11:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196523; x=1762801323; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCgyYYl17212afWq0WmdVNHdmhfE4WpVfwvlvWkdR/I=;
        b=N7RcTaat+sbzxC9Umtmn4+rvXHFsVIoj/FJ/zTHEKLmoLmxdoFeYS9RDheteD6khOX
         2KQChajtn9cnBzWKlrtajuIxjgJzeSa9NI52+nVuzgV5xbnRbX/g7/65F+39HreoF8IZ
         WKb2qF88Dl1Km3jspNDf5erwdt6ydN90mQdwndCkmgYohsJ5JUqunieSd6gxbxFUWnb6
         ZFhRCvISnHkXllWrcB0G1sc1/JR4JTJZbv2BmBlJ1R22wbKdrVVMeCEwIPHn7ULfARB1
         PS3o2bvu9RrpSA3qh+durUZvt9+2yif+pMrIW0peRatXwvPc//qo+nlvarnnGevj5KEo
         JkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196523; x=1762801323;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCgyYYl17212afWq0WmdVNHdmhfE4WpVfwvlvWkdR/I=;
        b=Bmi2PR/I7LoOf1XDgT7qSCU/4AIUz1iR2zFRsuz699GZ7PJG9EwIaaV285HY45uvNG
         lnAHLyFN08RVGJE/QoL8SpsEIdjGSzEk07Mv4xym2qV9UJR9KoZ8Va/8dBTjoTQQU1EX
         ZayLZgvJ1CX4B0wle1R4kVvAlL44pDYZ0qfX0NFq9LbRa4bPDGse15nvTtSWLhLKnt+R
         qP7ASUSYf+hMibz+q/WMUrmFLpp2rhlQ8jr+oC/AxfHjeUC56UPuq9p3PHGAkA76m7Nw
         hzkHgeKxk3irLvViCLAumvxZaKdBB+OHqw5ldB7t0H2Ul8EjmQFVvjj0NqGfUO2k2seL
         zLCg==
X-Forwarded-Encrypted: i=1; AJvYcCU28+OEEZbdqzUdUYvCEejHU5005vDeRBQnDHS6DmW/eiRO3P2Dv11703TxojxEzr/yUTIcHNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytEhZu2q49rqKitGeWIE21x1g+Sjlc+ifXrTvT+unr/kxMSfyu
	tXI2W68NeQy5b675lbl6n94TfgMgo17FDmXHYGfuOqSJ2lrAS3EtcPp1
X-Gm-Gg: ASbGnctOvenOKu7wdpO5Dm7HhRA40C6wbQqnw00Jc8uc4FR+ixpj1SnKH1UPy1HhxHF
	kjNRdMr1LjO2WZ5GOkhP8I7zPPxSnrKDhYf3TfS2qwX2enVnVzjfEd3HW/CT7b+XaOUVZUXO3kE
	RIORvoFXy4N0A7OLf2hwytlUIeoMlO7JeX9xr12bipzlGhkLxDThgYCk66hW6JIUwv0WYWTiD1+
	4s9gKhQw/VPi5p/OKE4WpNj0BcEUkKqg/eROnjc15kjE2CJ5nlfpMwFflnqA8yehJyEqX4KG6gx
	yboa/ibnV7I/yJdWQKXmborefApS5mpmcwqlC+jP0Mk5tesxqdZF06b85mxmPnERrtoB+QweUgn
	NcNOUZ4M8euobEfHd8WK6dTDUmsHlGoHi4q9oubZfMgrZ+EUuWlJ14DabtgF3TRtBxm0h1OsE8V
	e5DA==
X-Google-Smtp-Source: AGHT+IF6ZrnGeB7r0RyVBzECaRGawNu02DZMNOtb1XSlboch2JDalhSDF7ll1MdUkogMoDYfu5R1OA==
X-Received: by 2002:a05:6122:250d:b0:54a:992c:8164 with SMTP id 71dfb90a1353d-5593e404ef5mr4706586e0c.7.1762196521682;
        Mon, 03 Nov 2025 11:02:01 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973c834e3sm358469e0c.11.2025.11.03.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:01:57 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 0/5] platform/x86: alienware-wmi-wmax: Add AWCC support for
 most models
Date: Mon, 03 Nov 2025 14:01:43 -0500
Message-Id: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABf8CGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nj3bTE3MycSt3i0oIC3UTjxESLFOOkJCPzRCWgjoKi1LTMCrBp0bG
 1tQCitVuzXQAAAA==
X-Change-ID: 20251013-family-supp-a3aa8d3bb27a
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 Cihan Ozakca <cozakca@outlook.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=DbFAwez0cjMr7osbfexuB3kDFZnSvUx7kQxtUW3PIsc=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkcf2QaPmz/etjZoiJ2e5P879lyZ5g6bLuqbQNPnTxsd
 GvixoTAjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjI5DKGX0y5/8XlvLrZfqpn
 Wn4KD9fbGWHfIsP287keg9qReZe2+jMyHFXv8m3y3L3lRosPV12jKMuEOW8/HL5ac21rndztYzb
 CvAA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

This patchset adds support for almost all models listed as supported by
the AWCC windows tool.

This is important because the "old" interface, which this driver
defaults, is supported by very few and old models, while most Dell
gaming laptops support the newer AWCC interface.

Thanks!

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Kurt Borja (5):
      platform/x86: alienware-wmi-wmax: Fix "Alienware m16 R1 AMD" quirk order
      platform/x86: alienware-wmi-wmax: Drop redundant DMI entries
      platform/x86: alienware-wmi-wmax: Add support for the whole "M" family
      platform/x86: alienware-wmi-wmax: Add support for the whole "X" family
      platform/x86: alienware-wmi-wmax: Add support for the whole "G" family

 drivers/platform/x86/dell/alienware-wmi-wmax.c | 104 +++++--------------------
 1 file changed, 20 insertions(+), 84 deletions(-)
---
base-commit: bd34bf518a5ffeb8eb7c8b9907ba97b606166f7b
change-id: 20251013-family-supp-a3aa8d3bb27a

-- 
 ~ Kurt


