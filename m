Return-Path: <stable+bounces-112347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE4A28C45
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE991686F1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392EE1494DF;
	Wed,  5 Feb 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YySPEn77"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E313AD22;
	Wed,  5 Feb 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763265; cv=none; b=gVHul4iyqZh443acXCX/BorROGPV+h7bRS1/BZMTE0R6wtmIDqBbB6I6KLF4fN6ceLj6WY3qsL3HCtBXVm9u22iypWqVDQQ2wrX2OmmfJJtAPO4RzoCQhDTIrCrhG72/jwipzybZU9rI+1XMZgPyl1bs196rOcEcIddQpvolrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763265; c=relaxed/simple;
	bh=AYSpeRrB/3zCnX7ZI7AKQX+JRPa8B5fRHotOirce01g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOFOMnyevPuqkqSZbez/4GQn4sWjijeGQKfp8fx0dxGwdrylNB23Jw7/LX8TZtq4lqTjQ4tNVLNOP+23Yb1gkyAqSIuvuKqch4ERo1XpbSpJMCk8bz78AdRHYuVZgTHlBztl+LkTlfYvlkIMvUNnn7eK+DKLaIwHPGQ3as+UjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YySPEn77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BA1C4CED1;
	Wed,  5 Feb 2025 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763264;
	bh=AYSpeRrB/3zCnX7ZI7AKQX+JRPa8B5fRHotOirce01g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YySPEn77h/UD8eg8ovxF3rHG3E0PA69L9g6PrVPTXdpdq9SBt63B51xkYq3nY9xI5
	 mMgZuVc8FJbm37rfbKQqQYBcbQvGBzp82tWvxXHskk6cafLIF8fQlsIJYC/Hfqnq0y
	 prfARCgJBlfb2UJ3Mh5oddmkV/oBxNex+ccYg+jI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+ec5f884c4a135aa0dbb9@syzkaller.appspotmail.com,
	Alan Stern <stern@rowland.harvard.edu>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.6 024/393] HID: core: Fix assumption that Resolution Multipliers must be in Logical Collections
Date: Wed,  5 Feb 2025 14:39:03 +0100
Message-ID: <20250205134421.225633127@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit 64f2657b579343cf923aa933f08074e6258eb07b upstream.

A report in 2019 by the syzbot fuzzer was found to be connected to two
errors in the HID core associated with Resolution Multipliers.  One of
the errors was fixed by commit ea427a222d8b ("HID: core: Fix deadloop
in hid_apply_multiplier."), but the other has not been fixed.

This error arises because hid_apply_multipler() assumes that every
Resolution Multiplier control is contained in a Logical Collection,
i.e., there's no way the routine can ever set multiplier_collection to
NULL.  This is in spite of the fact that the function starts with a
big comment saying:

	 * "The Resolution Multiplier control must be contained in the same
	 * Logical Collection as the control(s) to which it is to be applied.
	   ...
	 *  If no Logical Collection is
	 * defined, the Resolution Multiplier is associated with all
	 * controls in the report."
	 * HID Usage Table, v1.12, Section 4.3.1, p30
	 *
	 * Thus, search from the current collection upwards until we find a
	 * logical collection...

The comment and the code overlook the possibility that none of the
collections found may be a Logical Collection.

The fix is to set the multiplier_collection pointer to NULL if the
collection found isn't a Logical Collection.

Reported-by: syzbot+ec5f884c4a135aa0dbb9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000109c040597dc5843@google.com/
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Fixes: 5a4abb36f312 ("HID: core: process the Resolution Multiplier")
Cc: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1125,6 +1125,8 @@ static void hid_apply_multiplier(struct
 	while (multiplier_collection->parent_idx != -1 &&
 	       multiplier_collection->type != HID_COLLECTION_LOGICAL)
 		multiplier_collection = &hid->collection[multiplier_collection->parent_idx];
+	if (multiplier_collection->type != HID_COLLECTION_LOGICAL)
+		multiplier_collection = NULL;
 
 	effective_multiplier = hid_calculate_multiplier(hid, multiplier);
 



