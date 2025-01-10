Return-Path: <stable+bounces-108225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE3A09976
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 19:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A007188D184
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25107212F94;
	Fri, 10 Jan 2025 18:32:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CF206F3F;
	Fri, 10 Jan 2025 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533952; cv=none; b=Tcljj1NIUnDGEg1fYixGLAtapV0QYozRNFw0OIOIltx+Nt6BTyHAA3qYp8vgUv3bu6yTrFmAz+hLK9OcrtQ72mYb3ctpACGgvHxb8lMjX+aDNF/WK4MCtVpxFd125PeXvWM0YKOU6V8xiCXxu9UxYZvQ6Py3BlN759kFcF8JPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533952; c=relaxed/simple;
	bh=ou7wA6VWgE3yMYYYuSEHJHU15fQsZbVSWZVBk+RduEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQHJvjBRVQr5fdPTvhBrPiTMcqKweEXcHl9tFbfL95oyt0dxnjum2A27abKKGxKoHGVGpVMs0GmiahmzApMARUpzWgEAZdtMIZCYEYogpMaNmKloeQzHVQprLlzW/ZsxnefsBzjV2bU6XvUsBLj4IUkkrrDNzVV8yY6deg5la2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 5E486233A3;
	Fri, 10 Jan 2025 21:32:26 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org,
	Juntong Deng <juntong.deng@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Clayton Casciato <majortomtosourcecontrol@gmail.com>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10 0/2] gfs2: backport to fix CVE-2023-52760
Date: Fri, 10 Jan 2025 21:32:11 +0300
Message-Id: <20250110183213.105051-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://www.cve.org/CVERecord/?id=CVE-2023-52760

[PATCH 5.10 1/2] gfs2: make function gfs2_make_fs_ro() to void type
[PATCH 5.10 2/2] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc


