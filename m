Return-Path: <stable+bounces-96248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD549E18BE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AB9166869
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E701E0B6D;
	Tue,  3 Dec 2024 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cA5tZti3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E813D890
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220251; cv=none; b=gtR6cXpbb37MLE31gKub+lehg/F5hW8dt2DkknszyODjJ2zLlCVtCe6H1/KCk5zp4QUasF4tRB1BCOOUG7oGjfwgBriNbEVCaxhUhrJd62KfpJYg2pDDwMlb+xP2j5pWpzzZM9XUjSIZfDZNiR/u+QK7qdaBYUWNBAHbubMjPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220251; c=relaxed/simple;
	bh=eaytmkw28J3T1ZE8cD5zFZl3KqUSTkIM6p9mY6G7KeA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k75QP/F63eG+cI5ia31V02zV7QRj2/FQXnR+Ye0NTTAY9MYSE4pniQWiC+Dj34hp8X3BAkhvyKBkdk7laTu0Go3vP/VizWIv/NQPacXqUXfZE2QBqJ3iLimTri3LOIDisChRDnTiHccHLWTUNiz683+rKhe6yCwIb15lHGcop/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cA5tZti3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB5AC4CECF;
	Tue,  3 Dec 2024 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733220251;
	bh=eaytmkw28J3T1ZE8cD5zFZl3KqUSTkIM6p9mY6G7KeA=;
	h=Subject:To:Cc:From:Date:From;
	b=cA5tZti3Hfqy65YHKknq/3UGgdGzy+TRtIwXWyAnkNSvqpCwC38njkY7rU3kGZQnG
	 +7gJ07SVHBwuSUX9dlbav/EyNacOD0IAOcy2D16u+wlhYjgU+Sj9z5sORwlF47UEZ7
	 1hapK/ElCIa/3O6Lcz0iXRr6YNR5rMG8/hOLSqLE=
Subject: FAILED: patch "[PATCH] dt-bindings: serial: rs485: Fix rs485-rts-delay property" failed to apply to 5.15-stable tree
To: michal.simek@amd.com,gregkh@linuxfoundation.org,krzk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:04:08 +0100
Message-ID: <2024120307-crazy-twitch-d786@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 12b3642b6c242061d3ba84e6e3050c3141ded14c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120307-crazy-twitch-d786@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


