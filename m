Return-Path: <stable+bounces-38726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F028A100E
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070E31C22F4F
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F72146D76;
	Thu, 11 Apr 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i7UQkgin"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9598657D3;
	Thu, 11 Apr 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831413; cv=none; b=dtsl2s8s9jUR1A3WP2OhoXmGZNiQY8omWfOt6/es1Be3cfS12/POZTOPP7xYWsk3WSUZ7SHYD+BPJ4CkWGyxQAfc38iBtfjdUAgKV3AAbxnRQL3T0KT2pyHfT6N6LU9QX0jxMdnEI6MSGqtw0WCfHtfZviIsAmsMXOjSv6M+80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831413; c=relaxed/simple;
	bh=2mLKE1kUeAylVhd0egRMC1IFBXGZVIdiPg2bFrGoXeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNkHoM1Pkz+OvjjBFcqYQFJSxDyH2RkBaCZQLvakRG7ZSYOt4f5FrZZeyB0hh8D+6+sOtr9lfpw8gCsLBN1RuealCdfJI7do/yWFx39VRMfI2caki9nEv3/hPx6ELdEJiv2UApmdaCCot6xoSAYjqZTFvF7oH7AAsyO4VrXX40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i7UQkgin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF7FC433C7;
	Thu, 11 Apr 2024 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831412;
	bh=2mLKE1kUeAylVhd0egRMC1IFBXGZVIdiPg2bFrGoXeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7UQkginYhc38nbGedh6YkvuE2aSqdX3Qb2zGOMGpmaduwDRheXo5bTIPo0JPdYI3
	 nh/neMA6mp20oJ+uIjazAqCxnVROC+ooL06aUAEHhs7f+rpjjosIpc5c6aSZkK7Gst
	 Q+z6NEF67YzAMTCvvby051CNeBu0BLUWx3l2/nwg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 105/114] selftests: mptcp: display simult in extra_msg
Date: Thu, 11 Apr 2024 11:57:12 +0200
Message-ID: <20240411095420.061502950@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <geliang.tang@suse.com>

commit 629b35a225b0d49fbcff3b5c22e3b983c7c7b36f upstream.

Just like displaying "invert" after "Info: ", "simult" should be
displayed too when rm_subflow_nr doesn't match the expect value in
chk_rm_nr():

      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      rm                                  [ ok ]
      rmsf                                [ ok ] 3 in [2:4]
      Info: invert simult

      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      rm                                  [ ok ]
      rmsf                                [ ok ]
      Info: invert

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231025-send-net-next-20231025-v1-10-db8f25f798eb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1740,7 +1740,10 @@ chk_rm_nr()
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
 		count=$((count + cnt))
-		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+		if [ "$count" != "$rm_subflow_nr" ]; then
+			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+			extra_msg="$extra_msg simult"
+		fi
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
 			print_ok "$suffix"



