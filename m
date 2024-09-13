Return-Path: <stable+bounces-76070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B4E97800E
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5609D281C32
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423641DA2E8;
	Fri, 13 Sep 2024 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yEWHXup7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C11D932B
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230827; cv=none; b=b9TlaVt2ccRUgJjcwQQfewwmvdToymwk+Cr6lOw+S3XpaA5y6kE9KKfLTpLg2yPuJC4+e7C6ZNIuSxH6AaEUSH+S2YtIfez82x8tJaa1m0eZqmO0X0wz7jgmBIF2VKN3MfZlVdBrOupekluYE8Wuouj2us57cMWkrSIEHlfWiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230827; c=relaxed/simple;
	bh=oaqtJN8s/Y6VN74bB8FXcKqv0vKBoF/BX73p8riETvg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gihtJNfpJ+Un0McKUVfZlOOAcIZVFFmhW8qwGs+lMRe+Ew0IJoIVymN96UhqgSujAbGQ/PKglFlvjspfI0pOtPkYIdu48YjtNMP7F5HBybNN3yRjTlLoRMGq0gZ5PY2PplEQkFsA/BPo0MDjGKEQ0YQrLDRQ6NJUMpJfVmQsl5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yEWHXup7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63140C4CEC0;
	Fri, 13 Sep 2024 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726230826;
	bh=oaqtJN8s/Y6VN74bB8FXcKqv0vKBoF/BX73p8riETvg=;
	h=Subject:To:Cc:From:Date:From;
	b=yEWHXup7gX6VRqLAFtfLBD1nlmVaFYJ8xlzlIzJu/Ncq6ciCvg9GgT5qWJYaatbUW
	 AcpNV5j+fxQo26SFWd3N50Jsn8OmUqD+OpB+HHuP1e2A66EGLG15ulcZYt3KKdTuX6
	 uGvoMJlnO5IJy3sr2uDfWgR152RWQsFfNeOzK3Ec=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: restrict fullmesh endp on 1st sf" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:33:43 +0200
Message-ID: <2024091343-excusably-laborer-3bef@gregkh>
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
git cherry-pick -x 49ac6f05ace5bb0070c68a0193aa05d3c25d4c83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091343-excusably-laborer-3bef@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

49ac6f05ace5 ("selftests: mptcp: join: restrict fullmesh endp on 1st sf")
4878f9f8421f ("selftests: mptcp: join: validate fullmesh endp on 1st sf")
e571fb09c893 ("selftests: mptcp: add speed env var")
4aadde088a58 ("selftests: mptcp: add fullmesh env var")
080b7f5733fd ("selftests: mptcp: add fastclose env var")
662aa22d7dcd ("selftests: mptcp: set all env vars as local ones")
9e9d176df8e9 ("selftests: mptcp: add pm_nl_set_endpoint helper")
1534f87ee0dc ("selftests: mptcp: drop sflags parameter")
595ef566a2ef ("selftests: mptcp: drop addr_nr_ns1/2 parameters")
0c93af1f8907 ("selftests: mptcp: drop test_linkfail parameter")
be7e9786c915 ("selftests: mptcp: set FAILING_LINKS in run_tests")
4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
ae947bb2c253 ("selftests: mptcp: join: skip Fastclose tests if not supported")
d4c81bbb8600 ("selftests: mptcp: join: support local endpoint being tracked or not")
4a0b866a3f7d ("selftests: mptcp: join: skip test if iptables/tc cmds fail")
0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
6c160b636c91 ("selftests: mptcp: update userspace pm subflow tests")
48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
8697a258ae24 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49ac6f05ace5bb0070c68a0193aa05d3c25d4c83 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 10 Sep 2024 21:06:36 +0200
Subject: [PATCH] selftests: mptcp: join: restrict fullmesh endp on 1st sf

A new endpoint using the IP of the initial subflow has been recently
added to increase the code coverage. But it breaks the test when using
old kernels not having commit 86e39e04482b ("mptcp: keep track of local
endpoint still available for each msk"), e.g. on v5.15.

Similar to commit d4c81bbb8600 ("selftests: mptcp: join: support local
endpoint being tracked or not"), it is possible to add the new endpoint
conditionally, by checking if "mptcp_pm_subflow_check_next" is present
in kallsyms: this is not directly linked to the commit introducing this
symbol but for the parent one which is linked anyway. So we can know in
advance what will be the expected behaviour, and add the new endpoint
only when it makes sense to do so.

Fixes: 4878f9f8421f ("selftests: mptcp: join: validate fullmesh endp on 1st sf")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240910-net-selftests-mptcp-fix-install-v1-1-8f124aa9156d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a4762c49a878..cde041c93906 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3064,7 +3064,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
+			pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		fi
 		fullmesh=1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3


