Return-Path: <stable+bounces-143218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A138AB349B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFCB3BDB7E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D3129D0B;
	Mon, 12 May 2025 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aHnZd0CI"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864836C
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044920; cv=none; b=tiNm/Jn85IlTpnUgwI91lqWSA8MDqnlLYaGUkbbTA6j8FG6zWADIAMhURrbHxFrsePD1CQVPSaI2FYwFVRzErPQ8y6SJW79Q0ih/nP1qQ54Z1KwQdXV/Xx4BzewBfRFio5bTE3LG2ysTz+mmGfv1OPdduMs5goKZ71bEFHZj4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044920; c=relaxed/simple;
	bh=ZUeB8DQoSTaG/YBjEAGl2VZXm3kP31IFm00kgaSncvY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DgTZnp7b5UvQ5Viwc9UX0HraK2j0KjEtxyPykv0n+J51l14LP+9tPjvVwewwUByHcdcKVHrQ/lIFgWGoe1Jg7hI4+TaCCYhtE0kbu1VCyKzRodm5c5w7you/F9vXTj60JRcv5U3L2qzgfA5CCtdtOwpVZ2BCvyCSjnOpy8A3sz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aHnZd0CI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E1CC4CEE7;
	Mon, 12 May 2025 10:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044919;
	bh=ZUeB8DQoSTaG/YBjEAGl2VZXm3kP31IFm00kgaSncvY=;
	h=Subject:To:Cc:From:Date:From;
	b=aHnZd0CILItpmFukrnOhh+J8+Fq3c06CXMPdzHlJQlf4fpYp5qQXjEOvfnW8xl+CD
	 +e+HcARlDXZfx22udvzxDtH2UcT39877eso0gqaU6z2KDHlZDX5Xs3avjrarCC/87a
	 uH7lndEPojC9v1N9AFA+MUxg2MXw/PlHRXHXI+SA=
Subject: FAILED: patch "[PATCH] iio: adc: ad7768-1: Fix insufficient alignment of timestamp." failed to apply to 5.4-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:15:06 +0200
Message-ID: <2025051206-accuracy-cover-113a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ffbc26bc91c1f1eb3dcf5d8776e74cbae21ee13a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051206-accuracy-cover-113a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffbc26bc91c1f1eb3dcf5d8776e74cbae21ee13a Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Sun, 13 Apr 2025 11:34:25 +0100
Subject: [PATCH] iio: adc: ad7768-1: Fix insufficient alignment of timestamp.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On architectures where an s64 is not 64-bit aligned, this may result
insufficient alignment of the timestamp and the structure being too small.
Use aligned_s64 to force the alignment.

Fixes: a1caeebab07e ("iio: adc: ad7768-1: Fix too small buffer passed to iio_push_to_buffers_with_timestamp()") # aligned_s64 newer
Reported-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250413103443.2420727-3-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 5a863005aca6..5e0be36af0c5 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -168,7 +168,7 @@ struct ad7768_state {
 	union {
 		struct {
 			__be32 chan;
-			s64 timestamp;
+			aligned_s64 timestamp;
 		} scan;
 		__be32 d32;
 		u8 d8[2];


