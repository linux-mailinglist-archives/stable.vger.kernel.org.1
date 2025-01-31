Return-Path: <stable+bounces-111835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F3A23FEB
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 16:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD05164E07
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4FD1E3DFA;
	Fri, 31 Jan 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="QvVIZAK4"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE28467;
	Fri, 31 Jan 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738338972; cv=none; b=SAWVSpMF3kyR6B2s/HnpqSaZN2BTcdp+0YfMzWCbUPDZgsKIYq+5rbFd/rRNEWh3s7UENNoONs6sDkXqk8ij/xkpsLjnFHBUGK9aqYOOdnuXngQfL7HasQRpGfeWALJgC4ZmNPf5Wd3Ch+PkBZ2PeBZRXle+A9n9zjOIU9SRhZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738338972; c=relaxed/simple;
	bh=AlvTp2e7ygReRno3yDhEOsCWB+UbBbU+N0HN5GEHHYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U02c9wLam06NZpr9p3g22wjUJl/F7RRfzoLacV/6fRxZynFLk0pV/TUdLCNog3s3qbHCjM/BOpC1tyOYw6MdOnkZfqsmMim2qT1mBtKu3hcLJETvl7usmz06QO69bEu9SSQKP50SrNrQ8AfUuphsg6GfUUQuNCaTfXNhhbE/iQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=QvVIZAK4; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3b05:0:640:71ba:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 29B4C60E97;
	Fri, 31 Jan 2025 18:54:38 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:b507::1:c])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4si9xF0IYSw0-HFZZSi0r;
	Fri, 31 Jan 2025 18:54:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1738338877;
	bh=mbcYtgUlY1C77x8spKxz3wyMkgYGxe6OWqM5gvL8y88=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=QvVIZAK4vpXHY6xCv8qPsxByyoObl6R4v1uaPSs7URPS06724ZfFzph+/xqQgkPZV
	 I/xYmyYmnHEUeGjuuCZPpkN8bAWDe+6BSfyEnf1wI/IY3d2AOwSjigfm03t6GWBal6
	 MidHWVHHvYV1/+zTbVuIFR7Pg9n5auJDdK5DnjwQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Wen Yang <wenyang@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	stable@vger.kernel.org
Subject: [PATCH] ftrace: Avoid potential division by zero in function_stat_show()
Date: Fri, 31 Jan 2025 18:53:46 +0300
Message-Id: <20250131155346.1313580-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cases rec->counter == {0, 1} are checked already.

While x * (x - 1) * 1000 = 0 have many solutions greater than 1 for both
modulo 2^32 and 2^64, that is not the case for x * (x - 1) = 0, so split
division into two.

It is not scary in practice because mod 2^64 solutions are huge and
minimal mod 2^32 solution is 30-bit number.

Cc: stable@vger.kernel.org
Fixes: e31f7939c1c27 ("ftrace: Avoid potential division by zero in function profiler")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 728ecda6e8d4..e1c05c4c29c2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -570,12 +570,12 @@ static int function_stat_show(struct seq_file *m, void *v)
 		stddev = rec->counter * rec->time_squared -
 			 rec->time * rec->time;
 
+		stddev = div64_ul(stddev, rec->counter * (rec->counter - 1));
 		/*
 		 * Divide only 1000 for ns^2 -> us^2 conversion.
 		 * trace_print_graph_duration will divide 1000 again.
 		 */
-		stddev = div64_ul(stddev,
-				  rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev, 1000);
 	}
 
 	trace_seq_init(&s);
-- 
2.34.1


