Return-Path: <stable+bounces-96070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F029E0681
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD43B160F43
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8375A202F96;
	Mon,  2 Dec 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KeZu3+7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411411FE47F
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151804; cv=none; b=rdcsN4MaYGlUJnV51EGC+7oN2OBRjGSIC4XQ85Br0GQy6wQh7VGpt5mBL9pe3aIzcaDwejcOZ6tlGKnBEafHwzVK/jB2SARpJGzeMVaQZKYGY7Qx++U+EeVtqVloVCqR7y1wYkTGGifpc1IIo/2IxIsCVxkPm4rmvyxzHiSFHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151804; c=relaxed/simple;
	bh=OY8s7z4TkD8YVEBg2vSDjroKLfr+8PjZyDSPUKkWKSs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IEnoPxlR+0pd/cSSX5xZfJ41NF6c0NDe0quXU6A5laZTGkmOAjgeNgTpPxYw/XTuU9HLPyNsoQ8C2xaO/dEYoQkCsxyndUrc5tp3jn5AbGZCVjmKysgPRPJ7AZun27CkUjnvS1AKbN2d7g/pcr6NyE3CmxOGKlEYKhefXZ7AFhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KeZu3+7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59553C4CED2;
	Mon,  2 Dec 2024 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733151803;
	bh=OY8s7z4TkD8YVEBg2vSDjroKLfr+8PjZyDSPUKkWKSs=;
	h=Subject:To:Cc:From:Date:From;
	b=KeZu3+7w1VgWuqRxrPY5EO03GvyzcnjLBchVzRyuRJcvqbNoE1whVt/ZsTLnZHlFf
	 pNUBmBpuJcptLxujuVVIEefHAEuXSCtQDSWBHWF/W7bhbe7dwjPKE4UUV1f3GMoK5z
	 NWMKP5gKidaPGJFXenlH63R8PNyrdP5QwyLvLRII=
Subject: FAILED: patch "[PATCH] perf/x86/intel/pt: Fix buffer full but size is 0 case" failed to apply to 5.4-stable tree
To: adrian.hunter@intel.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:03:20 +0100
Message-ID: <2024120220-comply-kissing-b2b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 5b590160d2cf776b304eb054afafea2bd55e3620
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120220-comply-kissing-b2b3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b590160d2cf776b304eb054afafea2bd55e3620 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Tue, 22 Oct 2024 18:59:07 +0300
Subject: [PATCH] perf/x86/intel/pt: Fix buffer full but size is 0 case

If the trace data buffer becomes full, a truncated flag [T] is reported
in PERF_RECORD_AUX.  In some cases, the size reported is 0, even though
data must have been added to make the buffer full.

That happens when the buffer fills up from empty to full before the
Intel PT driver has updated the buffer position.  Then the driver
calculates the new buffer position before calculating the data size.
If the old and new positions are the same, the data size is reported
as 0, even though it is really the whole buffer size.

Fix by detecting when the buffer position is wrapped, and adjust the
data size calculation accordingly.

Example

  Use a very small buffer size (8K) and observe the size of truncated [T]
  data. Before the fix, it is possible to see records of 0 size.

  Before:

    $ perf record -m,8K -e intel_pt// uname
    Linux
    [ perf record: Woken up 2 times to write data ]
    [ perf record: Captured and wrote 0.105 MB perf.data ]
    $ perf script -D --no-itrace | grep AUX | grep -F '[T]'
    Warning:
    AUX data lost 2 times out of 3!

    5 19462712368111 0x19710 [0x40]: PERF_RECORD_AUX offset: 0 size: 0 flags: 0x1 [T]
    5 19462712700046 0x19ba8 [0x40]: PERF_RECORD_AUX offset: 0x170 size: 0xe90 flags: 0x1 [T]

 After:

    $ perf record -m,8K -e intel_pt// uname
    Linux
    [ perf record: Woken up 3 times to write data ]
    [ perf record: Captured and wrote 0.040 MB perf.data ]
    $ perf script -D --no-itrace | grep AUX | grep -F '[T]'
    Warning:
    AUX data lost 2 times out of 3!

    1 113720802995 0x4948 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x2000 flags: 0x1 [T]
    1 113720979812 0x6b10 [0x40]: PERF_RECORD_AUX offset: 0x2000 size: 0x2000 flags: 0x1 [T]

Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20241022155920.17511-2-adrian.hunter@intel.com

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fd4670a6694e..a087bc0c5498 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -828,11 +828,13 @@ static void pt_buffer_advance(struct pt_buffer *buf)
 	buf->cur_idx++;
 
 	if (buf->cur_idx == buf->cur->last) {
-		if (buf->cur == buf->last)
+		if (buf->cur == buf->last) {
 			buf->cur = buf->first;
-		else
+			buf->wrapped = true;
+		} else {
 			buf->cur = list_entry(buf->cur->list.next, struct topa,
 					      list);
+		}
 		buf->cur_idx = 0;
 	}
 }
@@ -846,8 +848,11 @@ static void pt_buffer_advance(struct pt_buffer *buf)
 static void pt_update_head(struct pt *pt)
 {
 	struct pt_buffer *buf = perf_get_aux(&pt->handle);
+	bool wrapped = buf->wrapped;
 	u64 topa_idx, base, old;
 
+	buf->wrapped = false;
+
 	if (buf->single) {
 		local_set(&buf->data_size, buf->output_off);
 		return;
@@ -865,7 +870,7 @@ static void pt_update_head(struct pt *pt)
 	} else {
 		old = (local64_xchg(&buf->head, base) &
 		       ((buf->nr_pages << PAGE_SHIFT) - 1));
-		if (base < old)
+		if (base < old || (base == old && wrapped))
 			base += buf->nr_pages << PAGE_SHIFT;
 
 		local_add(base - old, &buf->data_size);
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index f5e46c04c145..a1b6c04b7f68 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -65,6 +65,7 @@ struct pt_pmu {
  * @head:	logical write offset inside the buffer
  * @snapshot:	if this is for a snapshot/overwrite counter
  * @single:	use Single Range Output instead of ToPA
+ * @wrapped:	buffer advance wrapped back to the first topa table
  * @stop_pos:	STOP topa entry index
  * @intr_pos:	INT topa entry index
  * @stop_te:	STOP topa entry pointer
@@ -82,6 +83,7 @@ struct pt_buffer {
 	local64_t		head;
 	bool			snapshot;
 	bool			single;
+	bool			wrapped;
 	long			stop_pos, intr_pos;
 	struct topa_entry	*stop_te, *intr_te;
 	void			**data_pages;


