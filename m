Return-Path: <stable+bounces-187666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC68BEAAC5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EF5F35F197
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DF929D291;
	Fri, 17 Oct 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRPvPWVJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272B29CB4D;
	Fri, 17 Oct 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718261; cv=none; b=ZEd4zvhxTHke0gdReP6leQknfQm8M3QbcJ3RrKDbnJOFY8uIm8F7pqi49lbt5B/UUyuaoDHyJYPMfYwHXwLRP/pTndML0y0FpbuRE0V+mpj2OoVODASRdycYjd0y4+G6ypmC2AIw29TR94IIDEzZ9yMs+E47fkww2SyamHz/aLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718261; c=relaxed/simple;
	bh=S9kaJkor/rZlw8dMKfvpC0oAHSyuGb0zTi6bHr0139k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qvwse9EY0XWSDh+N//EfsJlVJzAUfdEogKmpSLEiSSLITfXyxeJ2ZNJIDS5ldNocX54W3GJSFa1uYC3dLXMQqVwQZ6/OK+me7fP2cgFp930frCh1p/j00bFtmT0hNKtrqHB84vVsFIsSrJK3cRJT96DTIOYiwvf5icjRdyYaC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRPvPWVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70487C116C6;
	Fri, 17 Oct 2025 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718261;
	bh=S9kaJkor/rZlw8dMKfvpC0oAHSyuGb0zTi6bHr0139k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KRPvPWVJBqaDQiKbRRariiT7qkFWkx4wz6Z4OYwPjmJHdLAx1xJ3AkRTkRG2cfSOc
	 ADOacu8VUM+skKxoeJ8l/VgIPVRD7s8Oc9MjN9+mfj72eWbY7xbs/EPy3dKlZ5B6pz
	 nixcQQKQNPSZP8mBpsmzkTRBGXScjgKwID/XxIAmsYbchIChorSZwTzPfwMDpxIW00
	 KRx7I/aFFv9yecJr9YPnk/1AZ10e0gEnF5zJEakAqUOx8gp1eR99W1bHPts92xVV8l
	 r9QvAfbgcVxVqjM8ynjGT02oTpPpcPKnErPKvbc64iOdwtMuP4BceeKUD/9dglwsLB
	 NoBa1WnUTFN0A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 18:24:02 +0200
Subject: [PATCH 5.15.y 3/3] Revert "docs/process/howto: Replace C89 with
 C11"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251017-v5-15-gcc-15-v1-3-da6c065049d7@kernel.org>
References: <20251017-v5-15-gcc-15-v1-0-da6c065049d7@kernel.org>
In-Reply-To: <20251017-v5-15-gcc-15-v1-0-da6c065049d7@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Akira Yokosawa <akiyks@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Federico Vaga <federico.vaga@vaga.pv.it>, Alex Shi <alexs@kernel.org>, 
 Hu Haowen <src.res@email.cn>, 
 Tsugikazu Shibata <shibata@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6984; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S9kaJkor/rZlw8dMKfvpC0oAHSyuGb0zTi6bHr0139k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+5a5+tNhT6+8p/T33Vb8G/2g9NpNf9wXD9E3fdiYVr
 Lr2JXTnxI5SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJZEYzMrTWTSx4/uCdaJBO
 xLbde3nEnGTNJM7oiDnwZK8u+Rr/4jYjQ+PMNbUR8mF6Kzd9ae9bN+VITYF4/Y+6nVG/y28JrF7
 6nxUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This reverts commit dc52117cd797f71f9686fa0cec91509eb7a9623d.

In this kernel version, C89 is still the default ISO standard.

The reverted commit was fixing commit e8c07082a810 ("Kbuild: move to
-std=gnu11"), introduced in v5.18, and not backported to older versions.
It was then not supported to be backported to v5.15. It can then safely
be reverted.

Fixes: 2f3f53d62307 ("docs/process/howto: Replace C89 with C11")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Alex Shi <alexs@kernel.org>
Cc: Hu Haowen <src.res@email.cn>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/howto.rst                    | 2 +-
 Documentation/translations/it_IT/process/howto.rst | 2 +-
 Documentation/translations/ja_JP/howto.rst         | 2 +-
 Documentation/translations/ko_KR/howto.rst         | 2 +-
 Documentation/translations/zh_CN/process/howto.rst | 2 +-
 Documentation/translations/zh_TW/process/howto.rst | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 12a4e7ebcbab..e4beeca57e5f 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -36,7 +36,7 @@ experience, the following books are good for, if anything, reference:
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
 
 The kernel is written using GNU C and the GNU toolchain.  While it
-adheres to the ISO C11 standard, it uses a number of extensions that are
+adheres to the ISO C89 standard, it uses a number of extensions that are
 not featured in the standard.  The kernel is a freestanding C
 environment, with no reliance on the standard C library, so some
 portions of the C standard are not supported.  Arbitrary long long
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index d02df35d0f6b..9554368a2ae2 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -44,7 +44,7 @@ altro, utili riferimenti:
 - "C:  A Reference Manual" di Harbison and Steele [Prentice Hall]
 
 Il kernel è stato scritto usando GNU C e la toolchain GNU.
-Sebbene si attenga allo standard ISO C11, esso utilizza una serie di
+Sebbene si attenga allo standard ISO C89, esso utilizza una serie di
 estensioni che non sono previste in questo standard. Il kernel è un
 ambiente C indipendente, che non ha alcuna dipendenza dalle librerie
 C standard, così alcune parti del C standard non sono supportate.
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 6a00e43868a2..d667f9d8a02a 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -65,7 +65,7 @@ Linux カーネル開発のやり方
  - 『新・詳説 C 言語 H&S リファレンス』 (サミュエル P ハービソン/ガイ L スティール共著 斉藤 信男監訳)[ソフトバンク]
 
 カーネルは GNU C と GNU ツールチェインを使って書かれています。カーネル
-は ISO C11 仕様に準拠して書く一方で、標準には無い言語拡張を多く使って
+は ISO C89 仕様に準拠して書く一方で、標準には無い言語拡張を多く使って
 います。カーネルは標準 C ライブラリに依存しない、C 言語非依存環境です。
 そのため、C の標準の中で使えないものもあります。特に任意の long long
 の除算や浮動小数点は使えません。カーネルがツールチェインや C 言語拡張
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index a787d31dcdbf..e3cdf0c84892 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -62,7 +62,7 @@ Documentation/process/howto.rst
  - "Practical C Programming" by Steve Oualline [O'Reilly]
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
 
-커널은 GNU C와 GNU 툴체인을 사용하여 작성되었다. 이 툴들은 ISO C11 표준을
+커널은 GNU C와 GNU 툴체인을 사용하여 작성되었다. 이 툴들은 ISO C89 표준을
 따르는 반면 표준에 있지 않은 많은 확장기능도 가지고 있다. 커널은 표준 C
 라이브러리와는 관계없이 freestanding C 환경이어서 C 표준의 일부는
 지원되지 않는다. 임의의 long long 나누기나 floating point는 지원되지 않는다.
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 2a910e3e904e..ee3dee476d57 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -45,7 +45,7 @@ Linux内核大部分是由C语言写成的，一些体系结构相关的代码
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
    《C语言参考手册（原书第5版）》（邱仲潘 等译）[机械工业出版社]
 
-Linux内核使用GNU C和GNU工具链开发。虽然它遵循ISO C11标准，但也用到了一些
+Linux内核使用GNU C和GNU工具链开发。虽然它遵循ISO C89标准，但也用到了一些
 标准中没有定义的扩展。内核是自给自足的C环境，不依赖于标准C库的支持，所以
 并不支持C标准中的部分定义。比如long long类型的大数除法和浮点运算就不允许
 使用。有时候确实很难弄清楚内核对工具链的要求和它所使用的扩展，不幸的是目
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index ce14d4ed5c5b..2043691b92e3 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -48,7 +48,7 @@ Linux內核大部分是由C語言寫成的，一些體系結構相關的代碼
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
    《C語言參考手冊（原書第5版）》（邱仲潘 等譯）[機械工業出版社]
 
-Linux內核使用GNU C和GNU工具鏈開發。雖然它遵循ISO C11標準，但也用到了一些
+Linux內核使用GNU C和GNU工具鏈開發。雖然它遵循ISO C89標準，但也用到了一些
 標準中沒有定義的擴展。內核是自給自足的C環境，不依賴於標準C庫的支持，所以
 並不支持C標準中的部分定義。比如long long類型的大數除法和浮點運算就不允許
 使用。有時候確實很難弄清楚內核對工具鏈的要求和它所使用的擴展，不幸的是目

-- 
2.51.0


