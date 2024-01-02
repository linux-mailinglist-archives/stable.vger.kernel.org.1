Return-Path: <stable+bounces-9188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B238821D03
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 14:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152301F2279C
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29547FC00;
	Tue,  2 Jan 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iD8YsvLF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9DFBF2
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 13:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA918C433C7;
	Tue,  2 Jan 2024 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704203139;
	bh=V+qtLkGUbQ6zBOsZDoMCM5mEapIB8Ry3BBo3lcsY8PU=;
	h=Subject:To:From:Date:From;
	b=iD8YsvLFtW/M6mJxNQAUzXCfbgiS94C/xn5LQtAnIopLhdAIEIUW2mCEZcrjDEx97
	 t9mtLefcz0gaszII4oRgfoV9ZIhojfLTBszQ6+0tkSSNw3WThoZ0szIfugEUzlFe1n
	 dl+dEv0JKyNTN41jG08/w5tcF0d1Pccej43WkyL0=
Subject: patch "Revert "usb: typec: class: fix typec_altmode_put_partner to put" added to usb-next
To: heikki.krogerus@linux.intel.com,chris.bainbridge@gmail.com,gregkh@linuxfoundation.org,rdbabiera@google.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Jan 2024 14:45:36 +0100
Message-ID: <2024010236-crispness-acquaint-1819@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    Revert "usb: typec: class: fix typec_altmode_put_partner to put

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 9c6b789e954fae73c548f39332bcc56bdf0d4373 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Tue, 2 Jan 2024 11:11:41 +0200
Subject: Revert "usb: typec: class: fix typec_altmode_put_partner to put
 plugs"

This reverts commit b17b7fe6dd5c6ff74b38b0758ca799cdbb79e26e.

That commit messed up the reference counting, so it needs to
be rethought.

Fixes: b17b7fe6dd5c ("usb: typec: class: fix typec_altmode_put_partner to put plugs")
Cc:  <stable@vger.kernel.org>
Cc: RD Babiera <rdbabiera@google.com>
Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Closes: https://lore.kernel.org/lkml/CAP-bSRb3SXpgo_BEdqZB-p1K5625fMegRZ17ZkPE1J8ZYgEHDg@mail.gmail.com/
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240102091142.2136472-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/class.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index aeae8009b9e3..4d11f2b536fa 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -267,7 +267,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	if (!partner)
 		return;
 
-	adev = &altmode->adev;
+	adev = &partner->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
@@ -497,8 +497,7 @@ static void typec_altmode_release(struct device *dev)
 {
 	struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-	if (!is_typec_port(dev->parent))
-		typec_altmode_put_partner(alt);
+	typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
 	kfree(alt);
-- 
2.43.0



