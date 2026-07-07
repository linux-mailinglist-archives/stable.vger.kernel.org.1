Return-Path: <stable+bounces-272416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0CuVAML5TGqSswEAu9opvQ
	(envelope-from <stable+bounces-272416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 15:06:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8D71BACD
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 15:06:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=DX12F3De;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=YAQczb83;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272416-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272416-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F64309DFEE
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43438414A11;
	Tue,  7 Jul 2026 12:58:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D23FD159
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 12:58:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429130; cv=none; b=YIz+tutdzv5dVotCEfLtcYdbQrcHRLqUg3KhHLKENHKWzQM61pCp4Z8IsLNEtDB1OLt2f5onkdO8r+L8vLb0KL1JXxUsQxeYcasLi5BVptEuaDv9rBP7SKQSTyvHiDNdKsFvXDvXGABQLFCO6v8hiD7oKJaFlKsXr9Jdy2VF6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429130; c=relaxed/simple;
	bh=hWtm8ZM2aIA2ZT1KJL0dTdHDIf+NYjTE56/Vi9ewZDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfIAqlGnSGJESdAeD4xO9Wf8ZiaSbkZxCERuoAJkZ+VDdXX2pfUDyaWnkTF8gDz+zM6RvfZ4PVT3nsm7A4ihP7pXsICH5yA1lWvEj/TgliT1gqKL7XKdWC9IxS9QFI2RzPY2280W8OJ7k7TOq9OZ2o3oWnQmhQzAUWy0QQU0eW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DX12F3De; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YAQczb83; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667C8w3E3676770
	for <stable@vger.kernel.org>; Tue, 7 Jul 2026 12:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=07HWQhr0mW5AKge6itfDXP0o6z4eCVE5Fz7
	ySaPNK+A=; b=DX12F3DeAwO+uo7rfH9oy/SRxcPIO6ddg6c8OO1d+2z9KG6Y0Jt
	OfCx8vQ5HavN4oVCoCNygsCZPI2ZYI9thuXK7s6WLwiQZ8buuWs8CDwaP/6VwEz5
	d3XLk/n901rtSw5tOF0hNLxd8z4+uBXaVvbHf7db790+lEZ3u4QlsPLe5NiEtUKf
	HjPeDbK/9qsLEULYBl9U4O85856tI4tD5Rochhu5UDFtImO5aYd6FqhEKkUidMY+
	32rxF2P4vPsbwEKchJ7Hl3qHooBWvUBhgAqJR2oDA7VprL7z3IZm+HIFg97+Hn6w
	zFx/DLt0juu+WhiujUPafnvcCHTC7UqcoyA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15a2dn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Jul 2026 12:58:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so51468711cf.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783429126; x=1784033926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07HWQhr0mW5AKge6itfDXP0o6z4eCVE5Fz7ySaPNK+A=;
        b=YAQczb83wsw8szNYa4aY/2r/AwJ2ihOKBDreehlKuGZDVIWKXXG+u7bPZWEtgyaskS
         QlHRnL/VoSlLZCPhkR/vPgJT1gOzGtG41biCeGjK6s+DkJPapJMJsA+Hs3RzPXEzCJ7D
         FqbVikZriCYXdK0FeDOjSSaERyG8nZdbn87mJhfaGvOAl5271fEwFGsjBePX7iQJK0It
         wwAG77Eo/QcpuQ1ZKV+ngg9c2wrpU2ZZRzemUazEyB9GJI4TbQJk6kARG8zkEKmp6HhX
         PUMYGabKdpe7nDQNeIAhX8uMiiUKgh7brG5VgHs0lKyS+qGJFSHajtlVnKs2sJq+uEPf
         XqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429126; x=1784033926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07HWQhr0mW5AKge6itfDXP0o6z4eCVE5Fz7ySaPNK+A=;
        b=rhuLWTP/VUfLDiwvxX5nnzRDK6d1O+phhuHwcQkxt9dXuckAnkUNSQkrehy/fOVSXT
         Y7NLdnH0HSaqJCVvppfdi9931SWX7d09oNEsHW1gR2sIc61Of6KopF8LhQP8k1G9Xtvw
         uLIn7kjnpE6QmydPBR5hrdPUzwvAL011bzLlDLqDspjSBIGqEm38oUqhbn52i5qalvvF
         qxXk8iyGRPMWJ7EU7S5EV8OhNcevGNat2xnriXXxChNMIbwGevr1Nza1qGPq3DBAWSA3
         5zFE96UucgdcUVubHu4H+ywvzReW72OD/PSnc5vHFwQkT9tVn+tXDLalycTwj70XKgcZ
         l9ww==
X-Forwarded-Encrypted: i=1; AHgh+RqJEgeYgwvsCaD89zpnmi56eg79HwLL5qvWVeLtzTNiJNXB2sW3Qu4lQHr8YWq8BZhKVQmOm7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sgjJpeF2UTMl21miK82H0H2+iyD7kQyg4pNeNgW90/PwDg3L
	AUAusOq56oFq3v4Z0COPgSczm716OzZwmr2VsOKamD2ViMCYOo7eYq4COri3gjqE5lpJjBtAls2
	lyeTMF6xms/BsmTSdDIV+kLKOam3DNrQFs0Z6LIeefLJ+YHRKSQ1uERwz2a4=
X-Gm-Gg: AfdE7ckHKVAa87rwb+K+lmPqwinYh6HBEN99L0Qrjm28sNgC5QKTXoyhoc8vrd8OSD1
	trTUWnvJzXfKXWPRTrohiHYtH/1Ls3uyK1QOxr58r/WawQQajFItQY7Twji1GzfNI+Das1mpRjR
	qscS8sYI23/0mS3Q6cJAIb5x16mKvSE4PptqI6UL3NGviCi8PQxs0QHt9/E/RXhFen6uYBCpV+x
	cQDs1gYEIGx68kvJUMciQ2hQ9M91Y7sKXXyEzQvvnvnr0M6d0RVH+4PY7tyiDcEiOJs++vscuRH
	3Kg9ViXqwWf2QgHF4r6UjkeBFgiM4PDNlmnf2kIiMYLpFNEwhnUi5YJMawX9w2jJ47HBGEFh1zA
	0B3JwIbk3sT8BUvpHdiFpS4ALTKSe7950diN8qLo=
X-Received: by 2002:ac8:7e88:0:b0:51c:4dc:287b with SMTP id d75a77b69052e-51c7479f5e1mr54014801cf.7.1783429125903;
        Tue, 07 Jul 2026 05:58:45 -0700 (PDT)
X-Received: by 2002:ac8:7e88:0:b0:51c:4dc:287b with SMTP id d75a77b69052e-51c7479f5e1mr54014531cf.7.1783429125444;
        Tue, 07 Jul 2026 05:58:45 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:47a8:72a4:c756:37f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm34539417f8f.13.2026.07.07.05.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:58:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
        Albert Esteve <aesteve@redhat.com>, Kees Cook <kees@kernel.org>,
        Alessandro Carminati <acarmina@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] bug: fix warning suppressions with kunit built as module
Date: Tue,  7 Jul 2026 14:58:37 +0200
Message-ID: <20260707125837.57256-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 81n1pewWwKJ6jpKON8gFdfIYYZyA1dOK
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4cf806 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=AttVjD3uJjTWtuEPW6QA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 81n1pewWwKJ6jpKON8gFdfIYYZyA1dOK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyNiBTYWx0ZWRfX6vVqqxrUDNyC
 VVURQrLNwuxRpt7bCt0cbU23t+7huyYoerNLbkqaLA/Ji5YChQndZuzmfd+/dd84hspOkJLIM6f
 1sA8OllkQmgMHwnKZVGuybqT5rKTB/M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyNiBTYWx0ZWRfX6/CbClUvAfkC
 scmK5nxRxafP4HTE+7gKewtu5r5ZpPOK1eFVw4jg2k7iagzRFYvOz5p1HdeHUwvwYFcPI/IBtm4
 wvZ8de3K1zk9Df1orYD+rrkSPm59dYL6u4IFflOg0hbdv2zd8Gn4HcIJAgmc+bzl3pBo3L3znfW
 I5+Ap32jRNKLUpr8CjZR1JajN2maLNGRTt/bQPkdRnjWgucd6XOJFqBZQHpnIp4dzrEMP2SaOwQ
 wgnbRMf/MpZ5foJNeC9b0z3Ct7LfiQ6NJuc2ioge0cvpIOnmFQ1XuPDGZ8PUnWRh2UKbuu1QJMb
 mfYwpiMSWaZz9fUOUtOiN53RnACw7sstesnJLtpnzXwnT5HfVWPZshZICeGveglAcyWwEMPKLtg
 Zu2VExX630tr820okfFCr0PzD0s3hYHGziYzMsgDJ8H98SSvDzfKaDDugiIPwyNSrCMKY0HmIJP
 tOhqN2KHKL1ddPfAxow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070126
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-272416-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skhan@linuxfoundation.org,m:linux@roeck-us.net,m:aesteve@redhat.com,m:kees@kernel.org,m:acarmina@redhat.com,m:akpm@linux-foundation.org,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:brgl@kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[linuxfoundation.org,roeck-us.net,redhat.com,kernel.org,linux-foundation.org,linux.dev,davidgow.net,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42B8D71BACD

CONFIG_KUNIT is a tristate symbol but the warning suppression code in
lib/bug.c is only built if it's built-in. Use IS_ENABLE(CONFIG_KUNIT) to
enable it for a loadable kunit module as well. When using a plain #ifdef,
the suppressions only work if kunit is built-in.

Cc: stable@vger.kernel.org
Fixes: 85347718ab0d ("bug/kunit: Core support for suppressing warning backtraces")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 lib/bug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bug.c b/lib/bug.c
index 292420f45811..b9820a0226f5 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -219,7 +219,7 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
 	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
 	has_args = bug->flags & BUGFLAG_ARGS;
 
-#ifdef CONFIG_KUNIT
+#if IS_ENABLED(CONFIG_KUNIT)
 	/*
 	 * Before the once logic so suppressed warnings do not consume
 	 * the single-fire budget of WARN_ON_ONCE().
-- 
2.47.3


