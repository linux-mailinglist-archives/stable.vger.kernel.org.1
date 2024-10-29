Return-Path: <stable+bounces-89159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5599B40C5
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 04:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEA91C22061
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0361EF959;
	Tue, 29 Oct 2024 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ISUZ9K6l"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3F149C4F
	for <Stable@vger.kernel.org>; Tue, 29 Oct 2024 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171485; cv=none; b=WRX7XFIBSRLZsUj9I7NWmYsi57UmVjRpcnKerTjDTDHz7kwrFH8bnCKYvMgzOjAS+7/i8jUfH8nB5Wc+3b+V+0upK3m40sp6rkYwjaTZlaPeSaCL5TGy+nwSLkP6h/qBqLrwIyPF7jdNGD6WFPUZ97x2CEjFfeOYyTlwZ0uAXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171485; c=relaxed/simple;
	bh=D9ryF+icLynAqmJ5hcP+6RCGBgSPeRAITsYWNqyzLQk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=R5AkWAHNZnO9IIaQ6ar73FNdaE12gT01d3LNEhjeuM95r/K31kaXXLkWRkXcnyp6ltS+wNUgmNK8GajndkZGcMBQqUaxW6wsS8UITP8VOuu2yb+PV5+MNsCxKIS+LovOSGa9fF70JmUJ1zMDOftEAtzJaBJwh/gNKvfaDDIa1A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ISUZ9K6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C4CC4CECD;
	Tue, 29 Oct 2024 03:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730171485;
	bh=D9ryF+icLynAqmJ5hcP+6RCGBgSPeRAITsYWNqyzLQk=;
	h=Subject:To:From:Date:From;
	b=ISUZ9K6lQKfb7dmVusyjC4E2yYcL3tShNithryeo5kBWnUbYhjMPi4wTLVQ4rUl3p
	 QX9GdurntncgpWbSQRiPO9MELKkFqmUTLvbsg54yKtwDZJ8g9qy9NsdEDaGz0ee/v4
	 AwncYgIcTIw/rkvRbAP7pDiw9FMfq9OyPgPyckm8=
Subject: patch "docs: iio: ad7380: fix supply for ad7380-4" added to char-misc-linus
To: jstephan@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Oct 2024 04:10:54 +0100
Message-ID: <2024102953-gentile-lavender-297e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    docs: iio: ad7380: fix supply for ad7380-4

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 795114e849ddfd48150eb0135d04748a8c81cec5 Mon Sep 17 00:00:00 2001
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 22 Oct 2024 15:22:40 +0200
Subject: docs: iio: ad7380: fix supply for ad7380-4

ad7380-4 is the only device from ad738x family that doesn't have an
internal reference. Moreover it's external reference is called REFIN in
the datasheet while all other use REFIO as an optional external
reference. Update documentation to highlight this.

Fixes: 3e82dfc82f38 ("docs: iio: new docs for ad7380 driver")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Link: https://patch.msgid.link/20241022-ad7380-fix-supplies-v3-5-f0cefe1b7fa6@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/iio/ad7380.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index 9c784c1e652e..6f70b49b9ef2 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -41,13 +41,22 @@ supports only 1 SDO line.
 Reference voltage
 -----------------
 
-2 possible reference voltage sources are supported:
+ad7380-4
+~~~~~~~~
+
+ad7380-4 supports only an external reference voltage (2.5V to 3.3V). It must be
+declared in the device tree as ``refin-supply``.
+
+All other devices from ad738x family
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+All other devices from ad738x support 2 possible reference voltage sources:
 
 - Internal reference (2.5V)
 - External reference (2.5V to 3.3V)
 
 The source is determined by the device tree. If ``refio-supply`` is present,
-then the external reference is used, else the internal reference is used.
+then it is used as external reference, else the internal reference is used.
 
 Oversampling and resolution boost
 ---------------------------------
-- 
2.47.0



