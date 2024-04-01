Return-Path: <stable+bounces-35395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC0E8943C0
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5131C2012B
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A61D48781;
	Mon,  1 Apr 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2acRtBPp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52AF40876;
	Mon,  1 Apr 2024 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991257; cv=none; b=CRjEBIbLiUckNSgn1ldJFJmUuHw/Amp/HxMfECbuGk16GnFeaONqqhQ4ULLq7xPQh1m9LHF+4X0zNJPjcmlVqRd3UR2joKOifr14ysmAE1BnrwUntrre+4DCmZzKIYu1GWs4sJmJO1Ie3M+YFbycAGHAFAw/xXRV+IICYhKe2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991257; c=relaxed/simple;
	bh=c5A7lwduq/faPvjQuT1r8VlmtRsrKAj4Yzpv1O4quuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEafQKRbyTPhmGD7Un18mALYT76PMV8jpiG+w6n5IR8PVhfSo/s9uFuID+9UQygcNLoSaX68kRvoQoKgGFMv2qX+ngwLJJLHbXDvsA42XlwcK8WXbhrKZYHTnABTLUMcaVDdiq4uFYicdmLqsbGW1Dm5vipv5uAKrwAtq163opE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2acRtBPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C34C433F1;
	Mon,  1 Apr 2024 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991257;
	bh=c5A7lwduq/faPvjQuT1r8VlmtRsrKAj4Yzpv1O4quuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2acRtBPpwPug9o4Es/VbEqltDeX+b+l8etSsc11b81OmJFUBJByRQfHX3rCXR2uUK
	 q9AeiIrDG5p/t2dPuOGUtYKw1Pxh7/8IE8shv4oyqAvx1FxC3vm3DDZ2/tzBQ4ACDo
	 /QN7ddtK1eWr6Dl2SZ3JBol4KlW4eY8vJzj/TZ/Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Laight <david.laight@aculab.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 181/272] minmax: add umin(a, b) and umax(a, b)
Date: Mon,  1 Apr 2024 17:46:11 +0200
Message-ID: <20240401152536.468117836@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit 80fcac55385ccb710d33a20dc1caaef29bd5a921 ]

Patch series "minmax: Relax type checks in min() and max()", v4.

The min() (etc) functions in minmax.h require that the arguments have
exactly the same types.

However when the type check fails, rather than look at the types and fix
the type of a variable/constant, everyone seems to jump on min_t().  In
reality min_t() ought to be rare - when something unusual is being done,
not normality.

The orginal min() (added in 2.4.9) replaced several inline functions and
included the type - so matched the implicit casting of the function call.
This was renamed min_t() in 2.4.10 and the current min() added.  There is
no actual indication that the conversion of negatve values to large
unsigned values has ever been an actual problem.

A quick grep shows 5734 min() and 4597 min_t().  Having the casts on
almost half of the calls shows that something is clearly wrong.

If the wrong type is picked (and it is far too easy to pick the type of
the result instead of the larger input) then significant bits can get
discarded.

Pretty much the worst example is in the derived clamp_val(), consider:
        unsigned char x = 200u;
        y = clamp_val(x, 10u, 300u);

I also suspect that many of the min_t(u16, ...) are actually wrong.  For
example copy_data() in printk_ringbuffer.c contains:

        data_size = min_t(u16, buf_size, len);

Here buf_size is 'unsigned int' and len 'u16', pass a 64k buffer (can you
prove that doesn't happen?) and no data is returned.  Apparantly it did -
and has since been fixed.

The only reason that most of the min_t() are 'fine' is that pretty much
all the values in the kernel are between 0 and INT_MAX.

Patch 1 adds umin(), this uses integer promotions to convert both
arguments to 'unsigned long long'.  It can be used to compare a signed
type that is known to contain a non-negative value with an unsigned type.
The compiler typically optimises it all away.  Added first so that it can
be referred to in patch 2.

Patch 2 replaces the 'same type' check with a 'same signedness' one.  This
makes min(unsigned_int_var, sizeof()) be ok.  The error message is also
improved and will contain the expanded form of both arguments (useful for
seeing how constants are defined).

Patch 3 just fixes some whitespace.

Patch 4 allows comparisons of 'unsigned char' and 'unsigned short' to
signed types.  The integer promotion rules convert them both to 'signed
int' prior to the comparison so they can never cause a negative value be
converted to a large positive one.

Patch 5 (rewritted for v4) allows comparisons of unsigned values against
non-negative constant integer expressions.  This makes
min(unsigned_int_var, 4) be ok.

The only common case that is still errored is the comparison of signed
values against unsigned constant integer expressions below __INT_MAX__.
Typcally min(int_val, sizeof (foo)), the real fix for this is casting the
constant: min(int_var, (int)sizeof (foo)).

With all the patches applied pretty much all the min_t() could be replaced
by min(), and most of the rest by umin().  However they all need careful
inspection due to code like:

        sz = min_t(unsigned char, sz - 1, LIM - 1) + 1;

which converts 0 to LIM.

This patch (of 6):

umin() and umax() can be used when min()/max() errors a signed v unsigned
compare when the signed value is known to be non-negative.

Unlike min_t(some_unsigned_type, a, b) umin() will never mask off high
bits if an inappropriate type is selected.

The '+ 0u + 0ul + 0ull' may look strange.
The '+ 0u' is needed for 'signed int' on 64bit systems.
The '+ 0ul' is needed for 'signed long' on 32bit systems.
The '+ 0ull' is needed for 'signed long long'.

Link: https://lkml.kernel.org/r/b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com
Link: https://lkml.kernel.org/r/41d93ca827a248698ec64bf57e0c05a5@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 51b30ecb73b4 ("swiotlb: Fix alignment checks when both allocation and DMA masks are present")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/minmax.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 5433c08fcc685..1aea34b8f19bf 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -51,6 +51,23 @@
  */
 #define max(x, y)	__careful_cmp(x, y, >)
 
+/**
+ * umin - return minimum of two non-negative values
+ *   Signed types are zero extended to match a larger unsigned type.
+ * @x: first value
+ * @y: second value
+ */
+#define umin(x, y)	\
+	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
+
+/**
+ * umax - return maximum of two non-negative values
+ * @x: first value
+ * @y: second value
+ */
+#define umax(x, y)	\
+	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, >)
+
 /**
  * min3 - return minimum of three values
  * @x: first value
-- 
2.43.0




