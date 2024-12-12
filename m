Return-Path: <stable+bounces-103777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA69D9EF9CC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4657B16C4C2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A133223E89;
	Thu, 12 Dec 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="duddlB9Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDDB223E7B;
	Thu, 12 Dec 2024 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025573; cv=none; b=a8CEkP+3nq5B2Zave4kI6/tcWhB/DUocfK9PARvt1IjV/0CR6eTFx28Xa7K+Acrr4okVIx0nEfHeKAUODLY4ruzh8tLoLtzr+olPG/0dDpZqmOaqOqKj1lWqmv3u/Ca4Eu7/3tObWIaqz/55LTJpHajiDoDURjHYRXzb21MheUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025573; c=relaxed/simple;
	bh=pIS3DmfGM29tnHRWBNaAg4rKx9RUvp++/0I0tac6L8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9dJBkHgCwPK4J8v0qwyuMMc7MEd18yN6J/wsHcrAOl08fJBjt55Mn5cS+68j2De+scZ0/d2G4YXKbtOu1mZ39kyN7PYieOOOGZamFozn8pN1Y2UkEOSWsF+Ve/aN+i1pPV1pq1ECR6yr0W4AIZLxmlCUZ6OvW1mPrWpKl3I61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=duddlB9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57904C4CECE;
	Thu, 12 Dec 2024 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025573;
	bh=pIS3DmfGM29tnHRWBNaAg4rKx9RUvp++/0I0tac6L8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duddlB9Z85uiZKGFl4v5Mf5zjjxjX5Nz/mKECiWsWMi59peHbupglI8BmzA863m03
	 VLquTNiX0I1hdQ6c2KveIbpQSE4Zro2MxvnUFXfWyvQU+YcZ7U+QiJlDzigGSywTpm
	 FXkBPhgJFNh5PZzkYvdSkR30RLe/UuDdU1397R6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.4 207/321] media: gspca: ov534-ov772x: Fix off-by-one error in set_frame_rate()
Date: Thu, 12 Dec 2024 16:02:05 +0100
Message-ID: <20241212144238.159458226@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit d2842dec577900031826dc44e9bf0c66416d7173 upstream.

In set_frame_rate(), select a rate in rate_0 or rate_1 by checking
sd->frame_rate >= r->fps in a loop, but the loop condition terminates when
the index reaches zero, which fails to check the last elememt in rate_0 or
rate_1.

Check for >= 0 so that the last one in rate_0 or rate_1 is also checked.

Fixes: 189d92af707e ("V4L/DVB (13422): gspca - ov534: ov772x changes from Richard Kaswy.")
Cc: stable@vger.kernel.org
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/gspca/ov534.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/gspca/ov534.c
+++ b/drivers/media/usb/gspca/ov534.c
@@ -847,7 +847,7 @@ static void set_frame_rate(struct gspca_
 		r = rate_1;
 		i = ARRAY_SIZE(rate_1);
 	}
-	while (--i > 0) {
+	while (--i >= 0) {
 		if (sd->frame_rate >= r->fps)
 			break;
 		r++;



