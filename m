Return-Path: <stable+bounces-16677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19DA840DF6
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CC81F2D009
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFAD15B0F8;
	Mon, 29 Jan 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s1ZLNw34"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9C15AADC;
	Mon, 29 Jan 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548196; cv=none; b=SXTIXblyAro759K33IIe/2MZlRnVrmrX71KDGEfoe9vAv+1+SlrRcBe8JiIh1AUrKoxykr9dsc8i/ZKjN2HI/ghc3JGdOhHOlF8gqZG4sUrwq+jVdRCPviCXAklWJ+CFYGT2uEAdffDqWFKsAUMfTbV178mUmELbGYPcpp++cdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548196; c=relaxed/simple;
	bh=eWOQ3s+7Bfzi1AcvugxTVrTPmuRDZWYEVxU/9FnfzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rljqv1P6qGI2X1Rn6lud6i8wbAuiohlKI/4nSvuxpFx97KCI3k11f7XJCvHUaA+Vw6tDWpAE4AWI99+R1EvL5MrbMWeZtEp3UdVvy8ta1BRVZOh6RoGVNSv6zHLaCQmeQQd1JyH5/4yWLkRb2Jxq8pZ1V4UdhpzYQDiD3T8X6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s1ZLNw34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652AFC43394;
	Mon, 29 Jan 2024 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548196;
	bh=eWOQ3s+7Bfzi1AcvugxTVrTPmuRDZWYEVxU/9FnfzMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1ZLNw34RXLBGzdGxOkQ7h/x5dhkoa3CvJKLSvrtHwoNa2xdilnfF7Sfv/y8TN5Fk
	 KGazEqyQ+/UkFFNZ4DAdtm6kxZQ7thAsvd+GjM2gLRUSipdGNG5/1TULmS9WFV3mNg
	 I7GB57YqGcaSqhh5+fWkdl6k1UoMD5WwQMPxtK1c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongchen Zhang <zhanghongchen@loongson.cn>,
	Weihao Li <liweihao@loongson.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.1 012/185] PM: hibernate: Enforce ordering during image compression/decompression
Date: Mon, 29 Jan 2024 09:03:32 -0800
Message-ID: <20240129165958.987279732@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
References: <20240129165958.589924174@linuxfoundation.org>
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

From: Hongchen Zhang <zhanghongchen@loongson.cn>

commit 71cd7e80cfde548959952eac7063aeaea1f2e1c6 upstream.

An S4 (suspend to disk) test on the LoongArch 3A6000 platform sometimes
fails with the following error messaged in the dmesg log:

	Invalid LZO compressed length

That happens because when compressing/decompressing the image, the
synchronization between the control thread and the compress/decompress/crc
thread is based on a relaxed ordering interface, which is unreliable, and the
following situation may occur:

CPU 0					CPU 1
save_image_lzo				lzo_compress_threadfn
					  atomic_set(&d->stop, 1);
  atomic_read(&data[thr].stop)
  data[thr].cmp = data[thr].cmp_len;
	  				  WRITE data[thr].cmp_len

Then CPU0 gets a stale cmp_len and writes it to disk. During resume from S4,
wrong cmp_len is loaded.

To maintain data consistency between the two threads, use the acquire/release
variants of atomic set and read operations.

Fixes: 081a9d043c98 ("PM / Hibernate: Improve performance of LZO/plain hibernation, checksum image")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Co-developed-by: Weihao Li <liweihao@loongson.cn>
Signed-off-by: Weihao Li <liweihao@loongson.cn>
[ rjw: Subject rewrite and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/power/swap.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -605,11 +605,11 @@ static int crc32_threadfn(void *data)
 	unsigned i;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -618,7 +618,7 @@ static int crc32_threadfn(void *data)
 		for (i = 0; i < d->run_threads; i++)
 			*d->crc32 = crc32_le(*d->crc32,
 			                     d->unc[i], *d->unc_len[i]);
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -648,12 +648,12 @@ static int lzo_compress_threadfn(void *d
 	struct cmp_data *d = data;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
 			d->ret = -1;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -662,7 +662,7 @@ static int lzo_compress_threadfn(void *d
 		d->ret = lzo1x_1_compress(d->unc, d->unc_len,
 		                          d->cmp + LZO_HEADER, &d->cmp_len,
 		                          d->wrk);
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -797,7 +797,7 @@ static int save_image_lzo(struct swap_ma
 
 			data[thr].unc_len = off;
 
-			atomic_set(&data[thr].ready, 1);
+			atomic_set_release(&data[thr].ready, 1);
 			wake_up(&data[thr].go);
 		}
 
@@ -805,12 +805,12 @@ static int save_image_lzo(struct swap_ma
 			break;
 
 		crc->run_threads = thr;
-		atomic_set(&crc->ready, 1);
+		atomic_set_release(&crc->ready, 1);
 		wake_up(&crc->go);
 
 		for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
 			wait_event(data[thr].done,
-			           atomic_read(&data[thr].stop));
+				atomic_read_acquire(&data[thr].stop));
 			atomic_set(&data[thr].stop, 0);
 
 			ret = data[thr].ret;
@@ -849,7 +849,7 @@ static int save_image_lzo(struct swap_ma
 			}
 		}
 
-		wait_event(crc->done, atomic_read(&crc->stop));
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 
@@ -1131,12 +1131,12 @@ static int lzo_decompress_threadfn(void
 	struct dec_data *d = data;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
 			d->ret = -1;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -1149,7 +1149,7 @@ static int lzo_decompress_threadfn(void
 			flush_icache_range((unsigned long)d->unc,
 					   (unsigned long)d->unc + d->unc_len);
 
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -1334,7 +1334,7 @@ static int load_image_lzo(struct swap_ma
 		}
 
 		if (crc->run_threads) {
-			wait_event(crc->done, atomic_read(&crc->stop));
+			wait_event(crc->done, atomic_read_acquire(&crc->stop));
 			atomic_set(&crc->stop, 0);
 			crc->run_threads = 0;
 		}
@@ -1370,7 +1370,7 @@ static int load_image_lzo(struct swap_ma
 					pg = 0;
 			}
 
-			atomic_set(&data[thr].ready, 1);
+			atomic_set_release(&data[thr].ready, 1);
 			wake_up(&data[thr].go);
 		}
 
@@ -1389,7 +1389,7 @@ static int load_image_lzo(struct swap_ma
 
 		for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
 			wait_event(data[thr].done,
-			           atomic_read(&data[thr].stop));
+				atomic_read_acquire(&data[thr].stop));
 			atomic_set(&data[thr].stop, 0);
 
 			ret = data[thr].ret;
@@ -1420,7 +1420,7 @@ static int load_image_lzo(struct swap_ma
 				ret = snapshot_write_next(snapshot);
 				if (ret <= 0) {
 					crc->run_threads = thr + 1;
-					atomic_set(&crc->ready, 1);
+					atomic_set_release(&crc->ready, 1);
 					wake_up(&crc->go);
 					goto out_finish;
 				}
@@ -1428,13 +1428,13 @@ static int load_image_lzo(struct swap_ma
 		}
 
 		crc->run_threads = thr;
-		atomic_set(&crc->ready, 1);
+		atomic_set_release(&crc->ready, 1);
 		wake_up(&crc->go);
 	}
 
 out_finish:
 	if (crc->run_threads) {
-		wait_event(crc->done, atomic_read(&crc->stop));
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 	stop = ktime_get();



