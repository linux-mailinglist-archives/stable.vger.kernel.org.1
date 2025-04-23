Return-Path: <stable+bounces-136025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73818A9918A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604BC1B847C3
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFF829116A;
	Wed, 23 Apr 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFdrWVsK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17095291156;
	Wed, 23 Apr 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421458; cv=none; b=L9jyrL55IfL5coJGsc8dIkFoEh0Y5pRswq2a1LTs3H4JbSlrIwDlYBM3kNW7Fg0ydcPK6Fzhabfd+n/tHOf3RsYD4l6VuU1jMutZtxi29+nhlvPRD4++HUU+41OBnxvh1ZGrR8u/jCCZQrGfUqGYxWkCaF+cIRi0bChit6DEe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421458; c=relaxed/simple;
	bh=0UUOiluXdDQAfU5ih+QRdxAmeM8Y7e3cluN/17n6Z5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch+Ie6PNa08VEDb6VYdcCByl/jjrZrWgygn3HS/YvdNsmvEVAHZ8YvoXzDvAkfgoniTzOgZZrSFuWDUbJ+hwByG+aMwB35T58Ongt1Ma8rYbXZKZyi4+De0TqpwsHt/ziCF0aOMwD5ML01UcTfFaPIoARjrJCkNxnSxi/lNWhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFdrWVsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0BDC4CEE2;
	Wed, 23 Apr 2025 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421458;
	bh=0UUOiluXdDQAfU5ih+QRdxAmeM8Y7e3cluN/17n6Z5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFdrWVsK/godHcLEEeAZd917drWMak/UAX/PHsdbeNjGuDw7EAMfkdgdUhLpxmyQV
	 +v1j3PAMgRvZkzkP3H7WVbG6IaXruVYq6YnNlB7Txcq0HN0pGKKVb6N+YGeeCq0te7
	 Up3P0docr8bEG7lfKpSdvZiX4H/L9wIh8l5tN6z4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 223/223] block: make struct rq_list available for !CONFIG_BLOCK
Date: Wed, 23 Apr 2025 16:44:55 +0200
Message-ID: <20250423142626.262537545@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 957860cbc1dc89f79f2acc193470224e350dfd03 upstream.

A previous commit changed how requests are linked in the plug structure,
but unlike the previous method, it uses a new type for it rather than
struct request. The latter is available even for !CONFIG_BLOCK, while
struct rq_list is now. Move it outside CONFIG_BLOCK.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Fixes: a3396b99990d ("block: add a rq_list type")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/blkdev.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -995,12 +995,12 @@ extern void blk_put_queue(struct request
 
 void blk_mark_disk_dead(struct gendisk *disk);
 
-#ifdef CONFIG_BLOCK
 struct rq_list {
 	struct request *head;
 	struct request *tail;
 };
 
+#ifdef CONFIG_BLOCK
 /*
  * blk_plug permits building a queue of related requests by holding the I/O
  * fragments for a short period. This allows merging of sequential requests



