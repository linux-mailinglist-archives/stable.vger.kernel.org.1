Return-Path: <stable+bounces-200187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3210CA8F4F
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 19:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DD623021688
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376FD354AF1;
	Fri,  5 Dec 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqx+zF//"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06038362AA0
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960645; cv=none; b=RZ6hDs+Akp8dTfoD7aNHwZ7SlnZMF2sp96vaM0nRSR1yAxIvB2eJ9pzOMKzjE56ux9ckGBrTL3/Ki0JUYqXVyFxeepmsX6+a3pqfcNHsNPNS/hE9Zc9g2AJT+4JSvDn9aO6Msb+VvyalvklAOCSfVWxkDdw9i3YQuaK6GIdUlVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960645; c=relaxed/simple;
	bh=6iGgmquBb2OQMyy4OCnTzg1W/C2l8RhX58tZjEEgFL0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D+nEaLt/wJLaIK8vRctszAWFANQnKD1tE2RF3p1GSUSAodil12H9P+fZDXUMEsRDu2awt3/zJqY0Mg8b+FsJ5FD5Y6LXSmkxW7r1jlcpzbI+O2XCAKSYHbers7q0wXTJu/9lCy1oCTmhJUTxq02Ge5sJH6q5BKn98ZOsMTsvOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqx+zF//; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6420c0cf4abso2697721d50.1
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764960643; x=1765565443; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmOeFvGS/shn95dKI0JtWqVywFDHQTTRXmnRsDr85GI=;
        b=dqx+zF//utaPQ+CH9Tsu9TLKyRfWWUjOVgifYF5c7wGrtyc38jOLyI9y5+uZB0q2Zg
         0CQrGUCJs5ajdTP3aOATmTZI7AF5N1/U8TYhXPXkcVjDHuIMrELVKTFWADKbN3RanydL
         NrrKCWXp9qFQXT68vgeZ0Gsfbm+4ePfhtysGwqSaiwsvjvo5N/OFcabV5YM5XsakGzpG
         LDI0/rjRradO2NyQYvjrWZo6yEqifG/H/MaxNB/pl9YxSa8Jm/pmXf7sqFBgV630MURj
         EAMnUqFXMw597UvXMYgb6d9pLd2PtMz1IBdViabpTe0dqIeElGsayQ2XMBI0tNFAsHpf
         qjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764960643; x=1765565443;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmOeFvGS/shn95dKI0JtWqVywFDHQTTRXmnRsDr85GI=;
        b=aSOYzNgqyUveEL01ESj/6awFo6wnDoPvDWCwVMa8t3MSWJaKp6R79qaXjHKtJs9IIx
         V1ZyEGItdI63IBMVEnGBsrZ9lwOitvurS8nRqxCyAKshh22RamuSdzXpEomeTz9H2l1p
         lJ1FY4SSvd9we7rRyKT0h9w9+uplaWp9o7kxdonkrRKzSjCOJ3o5cqTh9T30/3YMxzw3
         4OSUilKFJ4ZgdWsyzRZi2/9o0hF7UGbCN7bd6vns7UDaIi+blXi2qOs0c4KZJg1w0Tcb
         cvvtM0FE4WqF5alXjwODXuL9ndmobcysNM1MeqdDc0IO59a2Mk5QjIKRbTfVK6/twz3i
         FFpw==
X-Forwarded-Encrypted: i=1; AJvYcCVGiH9MYkIlj725aq/Me1zyleOyTX3VrD5Lyye+tbzIuhobOqq1p6vHaSZEZubYs6aBMF3whyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW4aTrsoZTHNeCTVVchKA9oKqnj7QhyVmCAEXYk/Ispv3/7TJs
	Ugz3OEvz+r45GWYwLY92T+nZB3N2GzOH2MdV+zPnVcouF6gl6hoLn6IT
X-Gm-Gg: ASbGncuxqZeVqzsWvkR4iQmmFwkuauypc+WfJD+CNp8Z60U4r4c4VQjHQNpb12s1F7U
	YiV9jEexdqGYJJHk/GfzQKGRW1DJOkIJX2iD4byJ7gIOX59ARuES4jsp8yr6oRHCsh1O6/Ukhn6
	kY38BMfZ4qFgwg7pE+750jrgkIzXd7XlhkDDhLy8hRkMqSFH76+6MT6legXAN8K3XgZVWGydl/v
	WzxPK+G2NifK1Pw8UgaFtD7JFEUVPEsfMD4DdYI3fG/rQAN4TmxwHP2D/fHFtiEYIlj1HcZchD2
	SM+R7JTqYfSgVvt16CImG0NmuN9Jep9w39+f2+LfKSfxJ9Js21RpHaQzXtLJQuOoLYn/oI1OeJY
	H1rr5UcwOHVzgBGFN4ePeJQWBhtVMd8bi1Qtq0LUtehMC1qScXm2qnV5UcBI5oh3dB0Wdt4zfEz
	SQaLFhaf8Yekmj
X-Google-Smtp-Source: AGHT+IG61DsBhh1ZgcKsskQQratX9ekKOF2MgGuutbt6NmFhXG9LVlbqb6z7YZyFCrS+rxydsl4mGw==
X-Received: by 2002:a05:690e:1507:b0:644:4771:2d34 with SMTP id 956f58d0204a3-64447712e56mr1909415d50.61.1764960642815;
        Fri, 05 Dec 2025 10:50:42 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c2f0aaf83sm4586407b3.32.2025.12.05.10.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:50:42 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 0/3] platform/x86: alienware-wmi-wmax: Add support for some
 newly released models
Date: Fri, 05 Dec 2025 13:50:09 -0500
Message-Id: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEpM2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDINBNLEpN1DU11DVPNUs2MjUwTDVJTVICqi4oSk3LrACbFB1bWwsAvi9
 vEFkAAAA=
X-Change-ID: 20251111-area-51-7e6c2501e4eb
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=681; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=6iGgmquBb2OQMyy4OCnTzg1W/C2l8RhX58tZjEEgFL0=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnGmnUV53fyBCTVFXnPsD+29LN9xazpL9bF2S0sEuZJC
 eY6z7m2o5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACaSe47hryh71vwdM78yvzod
 9G1t4c0DMceiDZtaNW4ZCGd9qT+lqMPw3+t24ZbDa5afrY2QT/spXb2G+eDmI1oclnHxzisCFoY
 W8wEA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi Ilpo,

I managed to get my hands on acpidumps for these models so this is
verified against those.

Thanks for all your latest reviews!

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Kurt Borja (3):
      platform/x86: alienware-wmi-wmax: Add support for new Area-51 laptops
      platform/x86: alienware-wmi-wmax: Add AWCC support for Alienware x16
      platform/x86: alienware-wmi-wmax: Add support for Alienware 16X Aurora

 drivers/platform/x86/dell/alienware-wmi-wmax.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
---
base-commit: 9b9c0adbc3f8a524d291baccc9d0c04097fb4869
change-id: 20251111-area-51-7e6c2501e4eb

-- 
 ~ Kurt


