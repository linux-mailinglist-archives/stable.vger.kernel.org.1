Return-Path: <stable+bounces-192871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13580C44A3B
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C633AC46C
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 23:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD823BD1B;
	Sun,  9 Nov 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sTTRis8q"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435A2E40E;
	Sun,  9 Nov 2025 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762731146; cv=none; b=QBOCzxkIWBHLBDT67RvcrmSa9hRBFjUptvZkNjNOBdAY6gl2DtNLu6pBTDY4t4OCYehV5lscyxcJECyLSuOi6DZcHzHZyxMn5scCYFjq7qR6ePKUG7j4dp378VVZ3u3J5dhGz6bTj/HazOKr5CcqcderwZUbbf8dG0JF83w0eeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762731146; c=relaxed/simple;
	bh=cN5E4hsnFbex6XZm2lWNS8X0PLAtD1Fk9wFC+yfUx/Y=;
	h=To:Cc:Message-ID:From:Subject:Date; b=Qrg/aHifWYIV0FZwVsuPEZOFdOuO74nBp17kptbSEcyjgw8hTXNG1EaIXF3J/Yw4KKwWCttAtLF+H/8kxOnm900bKna8PweyGWKt71Suqs547I+keotUWPoiXmqmzC/Xge4CQLga1c673EnEukBgMv+WZDt9LTVXBGfHSx9dILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sTTRis8q; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D0C9EC0096;
	Sun,  9 Nov 2025 18:32:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 09 Nov 2025 18:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762731141; x=1762817541; bh=nx4FOrWdSq+YAbCvyjoWIFM0L4cd
	YEzeFfgYi/pIqlo=; b=sTTRis8q4cGmdKtjI7SQR5NMchmNSUj9D2hEv2YLMbmC
	8W2R4duBlMvcfkFtQbaF1innN67sAqe/j+vhwMyCjaPcV5ozcZoR6DPaAua0YEky
	X66t2MuVcTfeWiJcM9IRXlSd0goYmxub6Hx662cM+OD2bGN/ZzeNJSyW6py5TWpI
	9F4SXOwSuC1687WcSYRG2sXK0cztIwUgy5GXuy55j11lqWyCM7yYmtx6+u9BkuN5
	cW/01r3zKfOz9HM+f6SKZrtBW2NhQfyDbik1X6fdBEzikJMTme4hRJlTY+3egQZP
	ypx+y2DMJe/UKoi7AI1XrkdITE/5WCv3CSIBebNsFA==
X-ME-Sender: <xms:gyQRaVxoHoSwFU4KR8ZgDOtrT2hPSwXtnwz7TK7KEIg8pZStBNUOYQ>
    <xme:gyQRadbog7rYoRV6h9uQxmyr-PmdrhegsZ4qJfn0OB8LKgs8gGJJafbT4fBqaOTsj
    Fao59dqo_yn6pWSCom4k4qydW2srLzCFiv833AipMytX5yEbnARVEA1>
X-ME-Received: <xmr:gyQRae10O_B0O-NV6Xdv97bGFa5Ik7zTA0PI0MzySsdAIdTe-Q3xz8urr9-oCMT1cUqY9Ly0Dr4DZ_rdFswUauF_zuKkjiQ55jM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeijeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    eukedugeettdegfffhfeejveevkedtgeeuudeggffgheegleejheeiffelgfeuueenucff
    ohhmrghinhepuggvsghirghnrdhorhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhu
    gidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepmhgrugguhieslhhinhhugidrihgsmhdrtghomhdprhgtphhtthho
    pehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnphhighhgihhnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegt
    shhgrhhouhhprdgvuhdprhgtphhtthhopegtvggurghrmhgrgiifvghllhesmhgrtgdrtg
    homhdprhgtphhtthhopehushgvrhhmheejseihrghhohhordgtohhmpdhrtghpthhtohep
    lhhinhhugiesthhrvggslhhighdrohhrghdprhgtphhtthhopegsvghnhheskhgvrhhnvg
    hlrdgtrhgrshhhihhnghdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gyQRaXc1RFdIknDVT28Jr6NJ5CHLiMceYEgqOPUG66Pwxxw-HYd_Zg>
    <xmx:gyQRaTLPt2hEREj_BMqP524Q5xj_cna2JkjukdC8Mx97Hz7EYoHNvw>
    <xmx:gyQRadrD7307-ZTMu5fxNNN3BReLwHYaAGmM17Otbr7WvFgOybJbvA>
    <xmx:gyQRaZtK7jqdKf0Bj1nmwjFPUpheifYGZsZGAszOqAytc_FGvrvSrg>
    <xmx:hSQRadKHSj-vVrXAFHXXRS0w98m3FHAElT2rKORMXn6cuMf0Zlzdnl2D>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Nov 2025 18:32:16 -0500 (EST)
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
    Michael Ellerman <mpe@ellerman.id.au>,
    Nicholas Piggin <npiggin@gmail.com>,
    Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Cedar Maxwell <cedarmaxwell@mac.com>,
    Stan Johnson <userm57@yahoo.com>,
    "Dr. David Alan Gilbert" <linux@treblig.org>,
    Benjamin Herrenschmidt <benh@kernel.crashing.org>,
    stable@vger.kernel.org,
    linuxppc-dev@lists.ozlabs.org,
    linux-kernel@vger.kernel.org
Message-ID: <22b3b247425a052b079ab84da926706b3702c2c7.1762731022.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2] powerpc: Add reloc_offset() to font bitmap pointer used for
 bootx_printf()
Date: Mon, 10 Nov 2025 10:30:22 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Since Linux v6.7, booting using BootX on an Old World PowerMac produces
an early crash. Stan Johnson writes, "the symptoms are that the screen
goes blank and the backlight stays on, and the system freezes (Linux
doesn't boot)."

Further testing revealed that the failure can be avoided by disabling
CONFIG_BOOTX_TEXT. Bisection revealed that the regression was caused by
a change to the font bitmap pointer that's used when btext_init() begins
painting characters on the display, early in the boot process.

Christophe Leroy explains, "before kernel text is relocated to its final
location ... data is addressed with an offset which is added to the
Global Offset Table (GOT) entries at the start of bootx_init()
by function reloc_got2(). But the pointers that are located inside a
structure are not referenced in the GOT and are therefore not updated by
reloc_got2(). It is therefore needed to apply the offset manually by using
PTRRELOC() macro."

Cc: Cedar Maxwell <cedarmaxwell@mac.com>
Cc: Stan Johnson <userm57@yahoo.com>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: stable@vger.kernel.org
Link: https://lists.debian.org/debian-powerpc/2025/10/msg00111.html
Link: https://lore.kernel.org/linuxppc-dev/d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com/
Reported-by: Cedar Maxwell <cedarmaxwell@mac.com>
Closes: https://lists.debian.org/debian-powerpc/2025/09/msg00031.html
Bisected-by: Stan Johnson <userm57@yahoo.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 0ebc7feae79a ("powerpc: Use shared font data")
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Improved commit log entry to better explain the need for PTRRELOC().
---
 arch/powerpc/kernel/btext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 7f63f1cdc6c3..ca00c4824e31 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -20,6 +20,7 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/udbg.h>
+#include <asm/setup.h>
 
 #define NO_SCROLL
 
@@ -463,7 +464,7 @@ static noinline void draw_byte(unsigned char c, long locX, long locY)
 {
 	unsigned char *base	= calc_base(locX << 3, locY << 4);
 	unsigned int font_index = c * 16;
-	const unsigned char *font	= font_sun_8x16.data + font_index;
+	const unsigned char *font = PTRRELOC(font_sun_8x16.data) + font_index;
 	int rb			= dispDeviceRowBytes;
 
 	rmci_maybe_on();
-- 
2.49.1


