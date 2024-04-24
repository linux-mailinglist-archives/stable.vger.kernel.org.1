Return-Path: <stable+bounces-41321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBBE8B0081
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 06:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7AEB23622
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 04:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2645913E031;
	Wed, 24 Apr 2024 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O5VZvKRV"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F113D886
	for <Stable@vger.kernel.org>; Wed, 24 Apr 2024 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932855; cv=none; b=EkGj5y7BTf8ajYb8EDVS/h0GC7ZKzLCx0tIL4N4hqZrKg84aK2T0C1eLKFkdGJyf3hG4EgrUakGSBqvxaRaT/bHK/29qnqKVjv47wxQc/wu+vuJgM9R1uRYs8yZnf8bFqSrSdvYrtcFZbhMTW6UUP9EApfEGNCnJHQ19iteU0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932855; c=relaxed/simple;
	bh=GGKNIi1feYIy+on7QyuVmg70nT5zaVnFViCaO8RU5wg=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=jivMxlvvGdH5wS/qHPD+mHAElhdCcTKcPwpLKnX8UK3tx7ArGBHSTfK51lTfk46jfrsLD0wkYxnUGzq9kntvu7SStY4yJQNSUA2AaU/oHNGpP6ySFemg0y6yaM6NbNiv7AXJRjV+XqAZBMpRLontF7Ygk8dWrabqDqWRnadMyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O5VZvKRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C0EC113CE;
	Wed, 24 Apr 2024 04:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713932855;
	bh=GGKNIi1feYIy+on7QyuVmg70nT5zaVnFViCaO8RU5wg=;
	h=Subject:To:From:Date:From;
	b=O5VZvKRVmvhBHpfj1dVplutUpDiba6J+ZpYuXDn28peeVc7y2KnLBUtSNhsi9qSaU
	 GXMP5HPL3djRaWVwyZQBWd9zymefChH+AeJXKSP93csjxz627iNS0YZYdJwqO3wVJ6
	 JTRxKaiLsDTE8/yde5lXU3Pba8TKGV3sJd3tvktQ=
Subject: patch "dt-bindings: iio: health: maxim,max30102: fix compatible check" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,conor.dooley@microchip.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 21:27:25 -0700
Message-ID: <2024042325-chewer-postcard-2f71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    dt-bindings: iio: health: maxim,max30102: fix compatible check

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 89384a2b656b9dace4c965432a209d5c9c3a2a6f Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 16 Mar 2024 23:56:57 +0100
Subject: dt-bindings: iio: health: maxim,max30102: fix compatible check

The "maxim,green-led-current-microamp" property is only available for
the max30105 part (it provides an extra green LED), and must be set to
false for the max30102 part.

Instead, the max30100 part has been used for that, which is not
supported by this binding (it has its own binding).

This error was introduced during the txt to yaml conversion.

Fixes: 5a6a65b11e3a ("dt-bindings:iio:health:maxim,max30102: txt to yaml conversion")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20240316-max30102_binding_fix-v1-1-e8e58f69ef8a@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../devicetree/bindings/iio/health/maxim,max30102.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
index c13c10c8d65d..eed0df9d3a23 100644
--- a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
@@ -42,7 +42,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: maxim,max30100
+            const: maxim,max30102
     then:
       properties:
         maxim,green-led-current-microamp: false
-- 
2.44.0



