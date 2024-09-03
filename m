Return-Path: <stable+bounces-72815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8B6969A65
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713D71F240FC
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA91A4E7C;
	Tue,  3 Sep 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xxzRp5oT"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3D19CC3F
	for <Stable@vger.kernel.org>; Tue,  3 Sep 2024 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360119; cv=none; b=fwSuQKdcBXIxLhQKBVoGYALEnHD7UnD+s1w7B5scXlAJixZs7SEWGm6JBfpVTeQSDaGuzUNARZtn4JGR4/5FX9iFWXniN/Ib5QTgizbernVz41bYaqS9meKrH8GsuDat87NzYZaPAsiMABheVvkJc19TTDvAGUxvUSjcEhmygyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360119; c=relaxed/simple;
	bh=G+E4BxkoJdQ7g5ojS1Hf+nhCCsUJ8yz7p3UFZ6i8358=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=PyQx4rXiza4tZczsEmcoo9zK65oMm7DOBVHFjdRwEQWaa5FZCMWXxo5/Ppy/zVrAa2rmTVRtcKx8nuArBbvKfbk6xuK3xPkRE7O/2j4mPly9ac1G3OUEQHTxTeQzEIJWQqTSxnz7NhCnyMs6fpwBhiMLA2x5nrhmPEODgBHnyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xxzRp5oT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15432C4CEC4;
	Tue,  3 Sep 2024 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360119;
	bh=G+E4BxkoJdQ7g5ojS1Hf+nhCCsUJ8yz7p3UFZ6i8358=;
	h=Subject:To:From:Date:From;
	b=xxzRp5oTwtfcoPbSvgOb0U1R1e3p0WPSKra33JvCg+P+4wf3BWBCAititgJxUQIDk
	 Lk4E/UNcEJNx89LjrOUntNmGgUTo/aEv5fmTa1NNmjf+jh5EL51opXs0Pveo+qi8tE
	 jG7gGMF8C1VMVqWDP2sRw2zqrnZ0iNEkNyOAsZ2A=
Subject: patch "iio: adc: ad7124: fix config comparison" added to char-misc-linus
To: mitrutzceclan@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dumitru.ceclan@analog.com,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 12:18:04 +0200
Message-ID: <2024090304-dismay-barcode-dff9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7124: fix config comparison

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 2f6b92d0f69f04d9e2ea0db1228ab7f82f3173af Mon Sep 17 00:00:00 2001
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
Date: Wed, 31 Jul 2024 15:37:23 +0300
Subject: iio: adc: ad7124: fix config comparison

The ad7124_find_similar_live_cfg() computes the compare size by
substracting the address of the cfg struct from the address of the live
field. Because the live field is the first field in the struct, the
result is 0.

Also, the memcmp() call is made from the start of the cfg struct, which
includes the live and cfg_slot fields, which are not relevant for the
comparison.

Fix by grouping the relevant fields with struct_group() and use the
size of the group to compute the compare size; make the memcmp() call
from the address of the group.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20240731-ad7124-fix-v1-2-46a76aa4b9be@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7124.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index c0b82f64c976..afb5f4d741e6 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -147,15 +147,18 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	bool live;
 	unsigned int cfg_slot;
-	enum ad7124_ref_sel refsel;
-	bool bipolar;
-	bool buf_positive;
-	bool buf_negative;
-	unsigned int vref_mv;
-	unsigned int pga_bits;
-	unsigned int odr;
-	unsigned int odr_sel_bits;
-	unsigned int filter_type;
+	/* Following fields are used to compare equality. */
+	struct_group(config_props,
+		enum ad7124_ref_sel refsel;
+		bool bipolar;
+		bool buf_positive;
+		bool buf_negative;
+		unsigned int vref_mv;
+		unsigned int pga_bits;
+		unsigned int odr;
+		unsigned int odr_sel_bits;
+		unsigned int filter_type;
+	);
 };
 
 struct ad7124_channel {
@@ -334,11 +337,12 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = (u8 *)&cfg->live - (u8 *)cfg;
+	cmp_size = sizeof_field(struct ad7124_channel_config, config_props);
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
-		if (cfg_aux->live && !memcmp(cfg, cfg_aux, cmp_size))
+		if (cfg_aux->live &&
+		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
 			return cfg_aux;
 	}
 
-- 
2.46.0



