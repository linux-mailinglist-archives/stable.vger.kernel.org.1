Return-Path: <stable+bounces-93115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5939CD765
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A421BB25B66
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25861885BF;
	Fri, 15 Nov 2024 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G9iTAwdZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE071885AA;
	Fri, 15 Nov 2024 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652855; cv=none; b=Rgdo7wd0+/SHowo7TERcQuxq5LQLLcR9CJw3+TWG5Z+YRkixrMlbMoGp8rmI09yXILTVj+EPLff3HJc37Zbh5tF0SaTAM/CExz0XU0jLfAaW5vt3kXTnjjgQPA3SRtfl3Latd4AL8jnFBiBJkiLi0ZFFO32B/MCDdmfArqEeYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652855; c=relaxed/simple;
	bh=NzRDInUm0G8BAxUcQiwgcB6TspyDB9Qj3oBQkveue4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQbsxBroqg1zFBjUYYoYJepwUB/GLHjBmbLTYtdBzWXXgatjPrRaM/6Mx3Sj6L/Mvz0yMHguyai1jxzD9L4J7XHfioemmYOenOniBfpBaaHRTNaEwUDC6LnyR0GZ19i65gbMyUkYlq1TluzaiACpVW0WZ/sNaDUY237fdhjDJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G9iTAwdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07C2C4CECF;
	Fri, 15 Nov 2024 06:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731652855;
	bh=NzRDInUm0G8BAxUcQiwgcB6TspyDB9Qj3oBQkveue4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9iTAwdZSbXCuE1iDCCyqLGFzm9USspGNITYU487ET30dAma3qwqZyxoGacjh97hH
	 Kzs0J31YmXh499ZvZwKHnf+MljvzdL9Qh3PYKOi3bZvg2NAmDul71q0MrgUfPJO1Fb
	 MwdNVp7ws9WV8Z0mSjshCsTlteN8WD+9weoDhGMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 05/52] HID: core: zero-initialize the report buffer
Date: Fri, 15 Nov 2024 07:37:18 +0100
Message-ID: <20241115063723.047266329@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.845867306@linuxfoundation.org>
References: <20241115063722.845867306@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.com>

[ Upstream commit 177f25d1292c7e16e1199b39c85480f7f8815552 ]

Since the report buffer is used by all kinds of drivers in various ways, let's
zero-initialize it during allocation to make sure that it can't be ever used
to leak kernel memory via specially-crafted report.

Fixes: 27ce405039bf ("HID: fix data access in implement()")
Reported-by: Benoît Sevens <bsevens@google.com>
Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 0757097d25507..3387e64d84412 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1482,7 +1482,7 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
 
 	u32 len = hid_report_len(report) + 7;
 
-	return kmalloc(len, flags);
+	return kzalloc(len, flags);
 }
 EXPORT_SYMBOL_GPL(hid_alloc_report_buf);
 
-- 
2.43.0




