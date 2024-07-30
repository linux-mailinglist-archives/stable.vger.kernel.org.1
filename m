Return-Path: <stable+bounces-62640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8163F94087E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 08:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431E8284B19
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 06:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB918F2DC;
	Tue, 30 Jul 2024 06:39:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A518FC60
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321545; cv=none; b=Fb31OFl8lnmSyQqDeqawh4X5/II6wqtQwzoFW54CzPVwLsKiINQigBw0RRJBx0b6fWruuszkKUOdx44DQQ+++X4SnTYTBDi0GJl28nzoqFrYBC6Bi9j7HcJhLK7s+mbnXo8JSxYze7SmHATh/PlQeeCCtNu8lh9vUZOPKrwWx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321545; c=relaxed/simple;
	bh=Awm1fFQDvWV5VbT0FBx9hUxkBQAPtZX3NZ7G+hrUqzY=;
	h=From:Date:Subject:To:Cc:Message-Id; b=DPqJOTwT9Ezq86oNkK8p/4/oQHeu/QnCR/WQof7e2jfE4YI4CsONpYwR4GDxyouOHzqqyFjmc6egyKzofVYFoYvRsJIXwsy1ZuSoT6nD4IykzBd4C6oI2zGMHjUnPxShZNyBDw4hPoTE2CnDFUj9M0f5x+TB1aKx8E/CmvU5sGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sYgVg-0005UO-1L;
	Tue, 30 Jul 2024 06:39:00 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Tue, 30 Jul 2024 06:36:29 +0000
Subject: [git:media_stage/fixes] media: v4l: Fix missing tabular column hint for Y14P format
To: linuxtv-commits@linuxtv.org
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sYgVg-0005UO-1L@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: v4l: Fix missing tabular column hint for Y14P format
Author:  Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date:    Sat Jun 8 18:41:27 2024 +0200

The original patch added two columns in the flat-table of Luma-Only
Image Formats, without updating hints to latex: above it.  This results
in wrong column count in the output of Sphinx's latex builder.

Fix it.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-media/bdbc27ba-5098-49fb-aabf-753c81361cc7@gmail.com/
Fixes: adb1d4655e53 ("media: v4l: Add V4L2-PIX-FMT-Y14P format")
Cc: stable@vger.kernel.org # for v6.10
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

---

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
index f02e6cf3516a..74df19be91f6 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
@@ -21,9 +21,9 @@ are often referred to as greyscale formats.
 
 .. raw:: latex
 
-    \scriptsize
+    \tiny
 
-.. tabularcolumns:: |p{3.6cm}|p{3.0cm}|p{1.3cm}|p{2.6cm}|p{1.3cm}|p{1.3cm}|p{1.3cm}|
+.. tabularcolumns:: |p{3.6cm}|p{2.4cm}|p{1.3cm}|p{1.3cm}|p{1.3cm}|p{1.3cm}|p{1.3cm}|p{1.3cm}|p{1.3cm}|
 
 .. flat-table:: Luma-Only Image Formats
     :header-rows: 1

