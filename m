Return-Path: <stable+bounces-87972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93429AD9EB
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 04:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2262C1C215E7
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 02:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A8148838;
	Thu, 24 Oct 2024 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eCs6J2P3"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F174040;
	Thu, 24 Oct 2024 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736848; cv=none; b=UR1E4dvnl9AqfyU1aWwKVmo61Wc45VuBb1HcQs/+DINK/YFL/MARwTZ5Ub3etBLBOibAG3kK/aqGs6DBBBaVqXry6r2ZpxxK88ROJHb4OzM2Wuqc4y+5FmQEUxSGkyonelanTmB1X28U0psJh4QryvdlO/2imSFtRmJaBMmXqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736848; c=relaxed/simple;
	bh=IvEc+AYeWPJJmtJ60ssOpgGH28HGIQWXYtW2hYd4OvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mkug1QTqS7ekd2OePiLdXRL7KmQ/TF6vjhNAvTujsFemG1+iP+oiFdWbtBrASzgBFbpiKQl5OIK4rdlET4iW3Frv5vH/ucQGqKrYlgjFA2YXscVVkX1JTeZFCWeFIQSG9DsDSuR7mRhHz0VkhPzp8QhBk5NipAO8cqswdP6T2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eCs6J2P3; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/rPi5
	Lcki+iBDALqPQLhIL7P+3qfjGOuEBBYE9xUBb4=; b=eCs6J2P3tr3ky7OPmlMYT
	UOZlnHUyIqbWHlsnIxf8OHrwgPYvfenxZQaVXpR4okazu+bOY/i9YKcHFOg/McAg
	/y3ty1Pj2qJ/n8gkPnmNEkzkhEjwNXin4mDk4YMMZbCv1rb+BIJhiT9eyHBddvB3
	siOBw28jMUKJ45XxBXtxdw=
Received: from thinkpadx13gen2i.. (unknown [111.48.58.12])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC339x2sBlnNkzrAA--.9816S2;
	Thu, 24 Oct 2024 10:27:03 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: skhan@linuxfoundation.org
Cc: i@zenithal.me,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	valentina.manea.m@gmail.com,
	Zongmin Zhou <zhouzongmin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] usbip: tools: Fix detach_port() invalid port error path
Date: Thu, 24 Oct 2024 10:27:00 +0800
Message-Id: <20241024022700.1236660-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8d1a298c-78e4-4dfd-a5fb-5dd96fb22e81@linuxfoundation.org>
References: <8d1a298c-78e4-4dfd-a5fb-5dd96fb22e81@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC339x2sBlnNkzrAA--.9816S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17Kry7uFWfGr4rJry7Jrb_yoWfCrg_Cr
	4Uur4DXrWYka4Fkrn5GF18CryrK3Z8Wr4kXa1UKr1fGa4qyrn5JFyDt3929F18ur1qvF1a
	y3Z5Xw1DZws8ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU89Xo7UUUUU==
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/1tbiLAWBq2cZRZMUFQABsr

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

The detach_port() doesn't return error
when detach is attempted on an invalid port.

Fixes: 40ecdeb1a187 ("usbip: usbip_detach: fix to check for invalid ports")
Cc: stable@vger.kernel.org
Reviewed-by: Hongren Zheng <i@zenithal.me>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 tools/usb/usbip/src/usbip_detach.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/usb/usbip/src/usbip_detach.c b/tools/usb/usbip/src/usbip_detach.c
index b29101986b5a..6b78d4a81e95 100644
--- a/tools/usb/usbip/src/usbip_detach.c
+++ b/tools/usb/usbip/src/usbip_detach.c
@@ -68,6 +68,7 @@ static int detach_port(char *port)
 	}
 
 	if (!found) {
+		ret = -1;
 		err("Invalid port %s > maxports %d",
 			port, vhci_driver->nports);
 		goto call_driver_close;
-- 
2.34.1


