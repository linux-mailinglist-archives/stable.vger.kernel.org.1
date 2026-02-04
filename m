Return-Path: <stable+bounces-213639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM5INr5gg2mfmAMAu9opvQ
	(envelope-from <stable+bounces-213639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:07:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E51E3E7F4D
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A32F3072367
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB382423162;
	Wed,  4 Feb 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PqbvGqZb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE941C2EE;
	Wed,  4 Feb 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217007; cv=none; b=BDqW7GxPikXmAgKopwkhDEPyUb56GwBvB9hdUC7P6Rf54TfLot++Ne2D06tIUjySja9VItutL+wqNZoWtdYT60ZZSLY+VmNRyl6mJq6NplfJb9V40iGwDkd6c9mBTlVzfDmqgpg1k4wFhrYgR0n44Pg31eIrKuZnAiXe9e6KCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217007; c=relaxed/simple;
	bh=pSDe8wu1rsS5smhWxIRX3UjfCWXih2DNXGm9PHUbwd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTLCMp+7XC79TjCYgeJWesbyJPCdG9URQ1UWtJ8E8G5rPUDRyS6w0Stlr+rCfdByTPsL1YZqWeiZOzyudimrxnwsrW2lcK2fT7kdTwBxbJFRO70O/b4n4QxDzg1gcVSEAWtbpKrBw3WxbW6jdSAn0gmwoQFOnAHzK2pHM6bTsiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PqbvGqZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3841C4CEF7;
	Wed,  4 Feb 2026 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217007;
	bh=pSDe8wu1rsS5smhWxIRX3UjfCWXih2DNXGm9PHUbwd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqbvGqZb3dq8XYl/usjnk03pVOtimCwj3HJMzIh+xoYzaqEhHq/gy/sYflUg8I7Ii
	 lelC7/tUTYJ8hmEM4KKs2EqP9qe4gxeGO7gFVWkENSYrC2r0jd2w+A5zM8HLhsJsZX
	 OsTBTgiQiHkQhTMl+jnQ8XWHqqnxxh5fzNMU2ziU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Maftei <alex.maftei@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 062/206] selftests/ptp: Add -X option for testing PTP_SYS_OFFSET_PRECISE
Date: Wed,  4 Feb 2026 15:38:13 +0100
Message-ID: <20260204143900.449989684@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213639-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E51E3E7F4D
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Maftei <alex.maftei@amd.com>

[ Upstream commit 3cf119ad5dc2b5c11385106d6d0ba86fbb47324c ]

The -X option was chosen because X looks like a cross, and the underlying
callback is 'get cross timestamp'.

Signed-off-by: Alex Maftei <alex.maftei@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 76868642e427 ("testptp: Add option to open PHC in readonly mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ptp/testptp.c | 31 ++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index d3cbd254a196d..faec606707de6 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -144,6 +144,7 @@ static void usage(char *progname)
 		" -t val     shift the ptp clock time by 'val' seconds\n"
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
+		" -X         get a ptp clock cross timestamp\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
@@ -160,6 +161,7 @@ int main(int argc, char *argv[])
 	struct ptp_clock_time *pct;
 	struct ptp_sys_offset *sysoff;
 	struct ptp_sys_offset_extended *soe;
+	struct ptp_sys_offset_precise *xts;
 
 	char *progname;
 	unsigned int i;
@@ -179,6 +181,7 @@ int main(int argc, char *argv[])
 	int list_pins = 0;
 	int pct_offset = 0;
 	int getextended = 0;
+	int getcross = 0;
 	int n_samples = 0;
 	int pin_index = -1, pin_func;
 	int pps = -1;
@@ -193,7 +196,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -267,6 +270,9 @@ int main(int argc, char *argv[])
 				return -1;
 			}
 			break;
+		case 'X':
+			getcross = 1;
+			break;
 		case 'z':
 			flagtest = 1;
 			break;
@@ -573,6 +579,29 @@ int main(int argc, char *argv[])
 		free(soe);
 	}
 
+	if (getcross) {
+		xts = calloc(1, sizeof(*xts));
+		if (!xts) {
+			perror("calloc");
+			return -1;
+		}
+
+		if (ioctl(fd, PTP_SYS_OFFSET_PRECISE, xts)) {
+			perror("PTP_SYS_OFFSET_PRECISE");
+		} else {
+			puts("system and phc crosstimestamping request okay");
+
+			printf("device time: %lld.%09u\n",
+			       xts->device.sec, xts->device.nsec);
+			printf("system time: %lld.%09u\n",
+			       xts->sys_realtime.sec, xts->sys_realtime.nsec);
+			printf("monoraw time: %lld.%09u\n",
+			       xts->sys_monoraw.sec, xts->sys_monoraw.nsec);
+		}
+
+		free(xts);
+	}
+
 	close(fd);
 	return 0;
 }
-- 
2.51.0




