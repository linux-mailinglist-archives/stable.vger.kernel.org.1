Return-Path: <stable+bounces-96249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D346A9E18C0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F54166A58
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916801E0B8A;
	Tue,  3 Dec 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBAO7soG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E71E0B73
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220260; cv=none; b=jLXt/UK+/liltY8J700UWEypKZ9oWLqPEvAd4eAJVBImH+64yVw+7Zt2fTJxaUoVMcwDBeSLf5APaXCKNO2JbtkVF0EFP4WWUMlzUY/2bmNESBe/ZBrWzWJJW4U499EMrfpLVNU6K9rZM2ImMPOeLocHqzjr7X6AudpN/FQ0LJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220260; c=relaxed/simple;
	bh=k78rUz/JHoqVe0gud8GASw+3c2FKOGYCZ99S/0OZ97E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cemJCyoi8ZSLykFfQb1jIRwxgvd4REKYUW4MnO0+hhj4As2/FqPEh8cQJ9FIahpGLZxbiUo+h8TEGgXLEav8LOmSlGxhDoSgTrLQjNCUvkhosVZPEopljONf3+xhweZBmWirnvmMzigOG2hBPzOhxZ14wRHydn1LWlmoqp7J3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZBAO7soG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA14C4CECF;
	Tue,  3 Dec 2024 10:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733220259;
	bh=k78rUz/JHoqVe0gud8GASw+3c2FKOGYCZ99S/0OZ97E=;
	h=Subject:To:Cc:From:Date:From;
	b=ZBAO7soGu38xODnEL/izJ9VFyymcU0bKD8Ctj3M+G+7Q9AUMt0VmDcCJA3AdBddh+
	 KXOD791CG2wMYq7vJ0e+SZZsRhX6qgZIiHqt5Q6OcnBcf5G86dSnlIMO3N7fvQX1jd
	 DrjCj8xwvNor3SBcaFT/wobUoS/p+0UHp0W+R5PI=
Subject: FAILED: patch "[PATCH] dt-bindings: serial: rs485: Fix rs485-rts-delay property" failed to apply to 5.10-stable tree
To: michal.simek@amd.com,gregkh@linuxfoundation.org,krzk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:04:08 +0100
Message-ID: <2024120308-yo-yo-bagful-0961@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 12b3642b6c242061d3ba84e6e3050c3141ded14c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120308-yo-yo-bagful-0961@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 12b3642b6c242061d3ba84e6e3050c3141ded14c Mon Sep 17 00:00:00 2001
From: Michal Simek <michal.simek@amd.com>
Date: Mon, 16 Sep 2024 11:53:06 +0200
Subject: [PATCH] dt-bindings: serial: rs485: Fix rs485-rts-delay property

Code expects array only with 2 items which should be checked.
But also item checking is not working as it should likely because of
incorrect items description.

Fixes: d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings to json-schema")
Signed-off-by: Michal Simek <michal.simek@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/820c639b9e22fe037730ed44d1b044cdb6d28b75.1726480384.git.michal.simek@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 9418fd66a8e9..b93254ad2a28 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -18,16 +18,15 @@ properties:
     description: prop-encoded-array <a b>
     $ref: /schemas/types.yaml#/definitions/uint32-array
     items:
-      items:
-        - description: Delay between rts signal and beginning of data sent in
-            milliseconds. It corresponds to the delay before sending data.
-          default: 0
-          maximum: 100
-        - description: Delay between end of data sent and rts signal in milliseconds.
-            It corresponds to the delay after sending data and actual release
-            of the line.
-          default: 0
-          maximum: 100
+      - description: Delay between rts signal and beginning of data sent in
+          milliseconds. It corresponds to the delay before sending data.
+        default: 0
+        maximum: 100
+      - description: Delay between end of data sent and rts signal in milliseconds.
+          It corresponds to the delay after sending data and actual release
+          of the line.
+        default: 0
+        maximum: 100
 
   rs485-rts-active-high:
     description: drive RTS high when sending (this is the default).


