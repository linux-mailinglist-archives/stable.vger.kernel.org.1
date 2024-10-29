Return-Path: <stable+bounces-89157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D97B9B40C3
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 04:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DC91F21D66
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 03:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC7D1EF959;
	Tue, 29 Oct 2024 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="smEVBPtc"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B911149C4F
	for <Stable@vger.kernel.org>; Tue, 29 Oct 2024 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171474; cv=none; b=tNE/T7YJwqaxO5T0D/EAgRXqr7m7wq54C9zwTknmxBGUFu9Kf7VdfMFYXON9HETdlK4DwC6EyE3HW/GuOTCZwBfzIHhv9iO013GIc6QJMsc3RCuOB4ln3Qywl2+p1qPXnDpWU7V/KCcGGibxZD2HThc3WYe5u76IzyEc4qfyxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171474; c=relaxed/simple;
	bh=yQPm8k9dYnXoOMSwOqziRMvd/BEPxXTcTGWqoPQSr3c=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=QXDSWFGGPOfyl6sJ1fMg42CTGk7WthYUqyUU1z8GV19tfQbS5UwHcvEXrAjlg06SbXT02UdMzdWBOP9h46clm6ZmBRk14WhsHrFMR0y6pCClejwRL9fdKGsAQ9Ith16pzO2oUGheaSvYJnDXQ4nLCsck03sdzKa4wsjbF+ln8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=smEVBPtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4B9C4CECD;
	Tue, 29 Oct 2024 03:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730171474;
	bh=yQPm8k9dYnXoOMSwOqziRMvd/BEPxXTcTGWqoPQSr3c=;
	h=Subject:To:From:Date:From;
	b=smEVBPtcKKaMVgANcnvVY016/1lpR7JnKvqamjVMMXb8jmfNbT6Zg0k6oDUHCF9qm
	 YZ9v9LcO8xXUxtL3FgvzNQfsskfLbwvJITbanomaAQo3XgGHxXpgJfpcNslbrsq1Dj
	 zzUSjnhYps31gmhl6tIkU5c8WZ+zdSf18li0aeDI=
Subject: patch "dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply" added to char-misc-linus
To: jstephan@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,conor.dooley@microchip.com,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Oct 2024 04:10:52 +0100
Message-ID: <2024102952-retool-sponsor-aa15@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From fbe5956e8809f04e9121923db0b6d1b94f2b93ba Mon Sep 17 00:00:00 2001
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 22 Oct 2024 15:22:36 +0200
Subject: dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply

ad7380-4 is the only device from ad738x family that doesn't have an
internal reference. Moreover its external reference is called REFIN in
the datasheet while all other use REFIO as an optional external
reference. If refio-supply is omitted the internal reference is
used.

Fix the binding by adding refin-supply and makes it required for
ad7380-4 only.

Fixes: 1a291cc8ee17 ("dt-bindings: iio: adc: ad7380: add support for ad738x-4 4 channels variants")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Link: https://patch.msgid.link/20241022-ad7380-fix-supplies-v3-1-f0cefe1b7fa6@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/adc/adi,ad7380.yaml          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index bd19abb867d9..0065d6508824 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -67,6 +67,10 @@ properties:
       A 2.5V to 3.3V supply for the external reference voltage. When omitted,
       the internal 2.5V reference is used.
 
+  refin-supply:
+    description:
+      A 2.5V to 3.3V supply for external reference voltage, for ad7380-4 only.
+
   aina-supply:
     description:
       The common mode voltage supply for the AINA- pin on pseudo-differential
@@ -135,6 +139,23 @@ allOf:
         ainc-supply: false
         aind-supply: false
 
+  # ad7380-4 uses refin-supply as external reference.
+  # All other chips from ad738x family use refio as optional external reference.
+  # When refio-supply is omitted, internal reference is used.
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380-4
+    then:
+      properties:
+        refio-supply: false
+      required:
+        - refin-supply
+    else:
+      properties:
+        refin-supply: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.47.0



