Return-Path: <stable+bounces-76989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ACF984576
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 14:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D58284CCD
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219611A3AB7;
	Tue, 24 Sep 2024 12:04:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A2126C02;
	Tue, 24 Sep 2024 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179469; cv=none; b=YPgltjzpKhFdwzEgS5v0xFiHEd0tVU2W41nD8dYuZn7jb8auMO/emTZ7q4Y8CYLTw+43VoCTE1SyAjIjll7BhPeqws24IrcWwC/5lOuLoUiRKp79v2zr5NnvKM7HyvjAubjB67o4HYTsJidM9RWrhY1pgVbMTrbzPTN9IhYtsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179469; c=relaxed/simple;
	bh=9rY5fpuEyJRnumCdsyQyKeJ+g6IdcaPoDi8eTpTCw2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CMVTbcTV8tW84nPOWtL5cbBmWSMjGv3IukH2gHvFJEMFt1jdCVisJdMucnYPEEJ9u3CL/8B2V3ErYcMigmhVmhTX+5/F1+28CYCtCdGqwqvBgHWxQtlxN8iwLXq4WkY2Vg7JwM/lCfII98eBCAq6kOLp6XyTA5I4JOT1/sqgxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 24 Sep
 2024 15:04:15 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 24 Sep
 2024 15:04:15 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Jaegeuk Kim
	<jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 6.1 0/1] f2fs: convert to MAX_SBI_FLAG instead of 32 in stat_show()
Date: Tue, 24 Sep 2024 05:04:10 -0700
Message-ID: <20240924120411.34948-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

This patch addresses an open issue of buffer overflow in
f2fs function stat_show(). On the off chance that si->sbi->s_flag
had one of its bits (on the higher end) set to 1, for_each_set_bit()
will loop more than s_flag[] can afford, leading in turn to
erroneous array access.

The issue in question has been fixed in commit 5bb9c111cd98
("f2fs: convert to MAX_SBI_FLAG instead of 32 in stat_show()") and
cherry-picked for 6.1 stable branch.

Modified patch can now be cleanly applied to linux-6.1.y. All of
the changes made to the patch in order to adapt it are described
at the end of commit message in [PATCH 6.1 1/1] f2fs: convert to
MAX_SBI_FLAG instead of 32 in stat_show().



