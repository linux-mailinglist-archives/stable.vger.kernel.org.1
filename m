Return-Path: <stable+bounces-4526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F88047DC
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90061F2160B
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6196FB1;
	Tue,  5 Dec 2023 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OaUmHEps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A16AC2;
	Tue,  5 Dec 2023 03:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3664C433C8;
	Tue,  5 Dec 2023 03:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747787;
	bh=2zQ28N0z1RPQX+dJRaZpNCE5OKI7XxbeFOz4YfuN63k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OaUmHEpsW5SQBruPPLAaAf9yJwqVYZ1t7zyivq5GYQ8Tl5SZETYhI7y9fBPGbPm6Z
	 WAGJDLD1SvLC1bZb5AYQ4jdAMgiIQv6yQ2guDJHu8DdS+mDQyFzCJmSmxPfikzHHBu
	 4+QGl3ZuQvLDANBUWPtWgGEDcUaYxVD5GWpy4EE4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 33/67] uapi: propagate __struct_group() attributes to the container union
Date: Tue,  5 Dec 2023 12:17:18 +0900
Message-ID: <20231205031521.714412213@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
References: <20231205031519.853779502@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 4e86f32a13af1970d21be94f659cae56bbe487ee ]

Recently the kernel test robot has reported an ARM-specific BUILD_BUG_ON()
in an old and unmaintained wil6210 wireless driver. The problem comes from
the structure packing rules of old ARM ABI ('-mabi=apcs-gnu'). For example,
the following structure is packed to 18 bytes instead of 16:

struct poorly_packed {
        unsigned int a;
        unsigned int b;
        unsigned short c;
        union {
                struct {
                        unsigned short d;
                        unsigned int e;
                } __attribute__((packed));
                struct {
                        unsigned short d;
                        unsigned int e;
                } __attribute__((packed)) inner;
        };
} __attribute__((packed));

To fit it into 16 bytes, it's required to add packed attribute to the
container union as well:

struct poorly_packed {
        unsigned int a;
        unsigned int b;
        unsigned short c;
        union {
                struct {
                        unsigned short d;
                        unsigned int e;
                } __attribute__((packed));
                struct {
                        unsigned short d;
                        unsigned int e;
                } __attribute__((packed)) inner;
        } __attribute__((packed));
} __attribute__((packed));

Thanks to Andrew Pinski of GCC team for sorting the things out at
https://gcc.gnu.org/pipermail/gcc/2023-November/242888.html.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311150821.cI4yciFE-lkp@intel.com
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://lore.kernel.org/r/20231120110607.98956-1-dmantipov@yandex.ru
Fixes: 50d7bd38c3aa ("stddef: Introduce struct_group() helper macro")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/stddef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 7837ba4fe7289..dcd50fb2164a1 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -27,7 +27,7 @@
 	union { \
 		struct { MEMBERS } ATTRS; \
 		struct TAG { MEMBERS } ATTRS NAME; \
-	}
+	} ATTRS
 
 /**
  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
-- 
2.42.0




