Return-Path: <stable+bounces-55082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4E09154B9
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6591C21F6A
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2D019B5A5;
	Mon, 24 Jun 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGS5IU5/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C41D2F24
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247709; cv=none; b=tQHPXJ1zwr0B6YWUjVc38BRZRXJSZ2+TkcQb8En2TPU91v/YOlO7uj59lb2xi3W2ZwF1zoxJnvOYRTM+61I9u0j3gDXlEd5DIMnjtVooy5KznMG3s4Ee8KSWkdFgiwlmdKBoj9o4MeAtPW9wdJmYm9k6tKMP0wOYY8wHMqo/VQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247709; c=relaxed/simple;
	bh=K4bUlJFYeY3aHEj7BWPRh/owbTFOM1bWVb0q2junRHA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nk1PxFg9p0aC7qC/Hh1+eUABrIy7FT3RAOzBK4pZ55EejJNO/x8tHxnQjxncA9U72arqFIfJCE3o7IubJ3aQ7jXrVByboVVXcvngqV6H5ckSGNnD6IHya6nUMHQ6cOIDHmHuwz8LGkUnuZoCrfQundu7S8CMvxZFlJyy5krhVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGS5IU5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91B6C2BBFC;
	Mon, 24 Jun 2024 16:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247709;
	bh=K4bUlJFYeY3aHEj7BWPRh/owbTFOM1bWVb0q2junRHA=;
	h=Subject:To:Cc:From:Date:From;
	b=dGS5IU5/xL+rrjMYymQisc7OJDQXErHrl3yeRBT2WxoItMyztbIoFSJiK8f8QMTBx
	 C2FvTcCxq5CB9+bz3UyRXqWsegGxfe6NKBFUCaIs+KgS/72iV2V+Eig7Q9dpdch3QN
	 xtp43VpdQbeBsYbWF0aD/b/Tx6BMcWTqKAAMzbOY=
Subject: FAILED: patch "[PATCH] dt-bindings: i2c: atmel,at91sam: correct path to" failed to apply to 6.1-stable tree
To: krzysztof.kozlowski@linaro.org,andi.shyti@kernel.org,conor.dooley@microchip.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:48:26 +0200
Message-ID: <2024062426-sleeve-manicure-e52d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d4e001ffeccfc128c715057e866f301ac9b95728
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062426-sleeve-manicure-e52d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d4e001ffeccfc128c715057e866f301ac9b95728 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Jun 2024 13:34:49 +0200
Subject: [PATCH] dt-bindings: i2c: atmel,at91sam: correct path to
 i2c-controller schema

The referenced i2c-controller.yaml schema is provided by dtschema
package (outside of Linux kernel), so use full path to reference it.

Cc: stable@vger.kernel.org
Fixes: 7ea75dd386be ("dt-bindings: i2c: convert i2c-at91 to json-schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

diff --git a/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml b/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
index b1c13bab2472..b2d19cfb87ad 100644
--- a/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
@@ -77,7 +77,7 @@ required:
   - clocks
 
 allOf:
-  - $ref: i2c-controller.yaml
+  - $ref: /schemas/i2c/i2c-controller.yaml#
   - if:
       properties:
         compatible:


