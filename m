Return-Path: <stable+bounces-43579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDF68C32EA
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B515B214D1
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6BA1C693;
	Sat, 11 May 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="v0aCBwDD"
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679151BC57
	for <stable@vger.kernel.org>; Sat, 11 May 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715448046; cv=none; b=R6tGGs41EWxg1DWciVAW8VWjmja0ofsYNwlIYV4UWOET+yK/sQUwBdvEXzsegOeJB1AI55ITNTTxBslUnqbpe/YFVFeiqkfX/uH2aH9kwOmJQkYV/WRgG5MCy0sVQ4+fEr6ZxgHp0OCCaQrVdNIkLRPCiHAxZ8TU3Jh5hnq+t2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715448046; c=relaxed/simple;
	bh=AhSOwC69hM3XlVIjsnSNM0G1yMqhIGrTPTpK23ca25c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NF4U4jHF/cLG3aZnYLTnariuqgUfgEUvCB6UjCoGMuX9oYqV7tkpZfBb+/PMLR60yJ4vQpThPBMZ1NgWJuVBI8TYoMWgQ97TS7xfV20cX8JX0p8Mx8IMrTRJO8NWwSJ/S1mwn0sLuDZhuwge1SI6PuIJygyGWPKbNVx3CIo7s5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=v0aCBwDD; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VcC6p6zbbzj2X;
	Sat, 11 May 2024 19:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715447698;
	bh=olnCKZ/f1+rGHwst2IyLMVXJF0OZbL9TePTxid+W8KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v0aCBwDDfrOK0t7ab95u87uh6DmHugSHxoso0UJ0C3NY8Hags0+yZG6SmgkUtU35u
	 nigJEiH+AIW/8IWMVPV5RsRAOCPJsyxUSCeNiOopbJMgy/l39NLhsPmeib+vd8ZPf5
	 rp4tfpHe3ulEwt5xSEuMZVZiuooyVwU/crOKJXQk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VcC6p1DKpzTHD;
	Sat, 11 May 2024 19:14:58 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 06/10] selftests/harness: Constify fixture variants
Date: Sat, 11 May 2024 19:14:41 +0200
Message-ID: <20240511171445.904356-7-mic@digikod.net>
In-Reply-To: <20240511171445.904356-1-mic@digikod.net>
References: <20240511171445.904356-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

FIXTURE_VARIANT_ADD() types are passed as const pointers to
FIXTURE_TEARDOWN().  Make that explicit by constifying the variants
declarations.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Will Drewry <wad@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240511171445.904356-7-mic@digikod.net
---

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/kselftest_harness.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 9d7178a71c2c..201040207c85 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -338,7 +338,7 @@ static inline pid_t clone3_vfork(void)
  * variant.
  */
 #define FIXTURE_VARIANT_ADD(fixture_name, variant_name) \
-	extern FIXTURE_VARIANT(fixture_name) \
+	extern const FIXTURE_VARIANT(fixture_name) \
 		_##fixture_name##_##variant_name##_variant; \
 	static struct __fixture_variant_metadata \
 		_##fixture_name##_##variant_name##_object = \
@@ -350,7 +350,7 @@ static inline pid_t clone3_vfork(void)
 		__register_fixture_variant(&_##fixture_name##_fixture_object, \
 			&_##fixture_name##_##variant_name##_object);	\
 	} \
-	FIXTURE_VARIANT(fixture_name) \
+	const FIXTURE_VARIANT(fixture_name) \
 		_##fixture_name##_##variant_name##_variant =
 
 /**
-- 
2.45.0


