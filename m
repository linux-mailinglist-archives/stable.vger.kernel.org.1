Return-Path: <stable+bounces-5063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD08280AD90
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 21:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC75A1C20C2E
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 20:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913B57311;
	Fri,  8 Dec 2023 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSwo5iz3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F750252;
	Fri,  8 Dec 2023 20:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB23C433C8;
	Fri,  8 Dec 2023 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702066186;
	bh=I466eE+xnip8ZqtgQ6/GRHSwKNzyZEsjGJvnLC6k9wQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BSwo5iz33TxP2TqUkqKmQ9lcSO1HjQ+d3tw8YtSKcJ1TaPvyQZlsNyObY+ecPIcKN
	 E7KnoUXS9Pv6xHy96/kFaAgyJDg4v1Q0EHY8hf2b+xwILzeLr6C19UharPJRycQmBU
	 sQoxdMaiAHTZFtMQORsO3/nFG2iMArTfANWP4DAnxoZ64eQFlAJOKkUBhIwp2aIn0W
	 BX4IH6O1q+i4Wdg6o084hniXT9ydu5JDDPFC4e5TnjVH5tqHhmNhjq2cn/HLX4WBrL
	 UGIxNqh2W19eL5xYFZ0sEmOyTE3582aaNJTgfPntbq++axNZQjtu01wX9O/0hhF7kj
	 LV7aQNCxFK/Aw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: Please merge commit 85c2ceaafbd3 ("mm/damon/sysfs: eliminate potential uninitialized variable warning") into >=5.19 stable trees
Date: Fri,  8 Dec 2023 20:09:43 +0000
Message-Id: <20231208200943.64138-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please merge commit 85c2ceaafbd3 ("mm/damon/sysfs: eliminate potential
uninitialized variable warning") to >=5.19 stable kernels.

In 2023-10-31, I sent[1] a fix for v5.19.  After a week, Dan found an issue in
the fix and sent a fix.  At that time, the commit that Dan was fixing was
merged in the mm tree but not in the mainline.  Hence, Dan didn't Cc stable@.

However, now the broken fix[1] is merged in the mainline as commit 973233600676
("mm/damon/sysfs: update monitoring target regions for online input commit"),
and all >=5.19 stable trees.  Hence Dan's fix should also applied to those
trees.  Please apply those.

Note that the bug was only potential[3] due to unchecked return value.
However, the unchecked return value was not an intentional behavior but a bug.
Hence we further made the return value to be checked[4].  The return value
check fix is also merged in the relevant stable trees, so the fix is now needed
for a real bug.

[1] https://lore.kernel.org/all/20231031170131.46972-1-sj@kernel.org/
[2] https://lore.kernel.org/all/739e6aaf-a634-4e33-98a8-16546379ec9f@moroto.mountain/
[3] https://lore.kernel.org/all/20231106165205.48264-1-sj@kernel.org/
[4] https://lore.kernel.org/all/20231106233408.51159-1-sj@kernel.org/


Thanks,
SJ

