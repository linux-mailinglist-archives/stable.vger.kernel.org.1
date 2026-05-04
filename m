Return-Path: <stable+bounces-243218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OQjA3in+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:04:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2ED4BE750
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 120F530182E6
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32983D904D;
	Mon,  4 May 2026 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="imM6uwx8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591B3D5667;
	Mon,  4 May 2026 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903320; cv=none; b=UwtkJgCsnaZNThtUd2fbjej87pFQXL0COuIXD9/t+KMYYyFZLOpTmHQLtRKkQmHNYsZlxoi7gR6ZzXodRhz0fKWHnje56IWGR8PQavotqtEdH1FIqqvjRNGM7OlQpDVBW/+GTcr5wSpE7aZZYre9EjLkc4z4GdSsmxT2Q0Uf3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903320; c=relaxed/simple;
	bh=/LBDcwDyiyuVhaktfNXwa7t/KY24rVNm5GHBQjZWNwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sta1Sh2F3QpanbOlYPr+wXmVAUDkYVwtNUK7/pz3omLFz7KMjGrSXdOhtIbx++AxzCzlbM1e3QfC3Vu35gZtgPIiYvwDI2Svw6CfSCuGy944jaLoQp9pHzKNLQSJS4/hNcZcFNHCjQvbPeqOJDM8V+/M/uB2hiRyD8YzJc3g+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=imM6uwx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A04C2BCB8;
	Mon,  4 May 2026 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903320;
	bh=/LBDcwDyiyuVhaktfNXwa7t/KY24rVNm5GHBQjZWNwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imM6uwx8Twp+Hepu2WgdUiFAr2fTp3yHLVAIVDCYnaOMNZ14WWkh5MJkKAhOLwvqa
	 deqCdhOngVswNIjcJc7/ipH4NUeGBTEjZN3ZwQJL+hpZri7szXxHTA7vM19xmEQHvp
	 D/MOCav9t2cZ9hOoIQep3kY+NZSjT0U5K5A+5lm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacqueline Wong <jacqwong@google.com>,
	Jordan Hand <jhand@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 7.0 188/307] tpm: tpm_tis: stop transmit if retries are exhausted
Date: Mon,  4 May 2026 15:51:13 +0200
Message-ID: <20260504135149.954945602@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: BF2ED4BE750
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243218-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacqueline Wong <jacqwong@google.com>

commit 949692da7211572fac419b2986b6abc0cd1aeb76 upstream.

tpm_tis_send_main() will attempt to retry sending data TPM_RETRY times.
Currently, if those retries are exhausted, the driver will attempt to
call execute. The TPM will be in the wrong state, leading to the
operation simply timing out.

Instead, if there is still an error after retries are exhausted, return
that error immediately.

Cc: stable@vger.kernel.org # v6.6+
Fixes: 280db21e153d8 ("tpm_tis: Resend command to recover from data transfer errors")
Signed-off-by: Jacqueline Wong <jacqwong@google.com>
Signed-off-by: Jordan Hand <jhand@google.com>
Link: https://lore.kernel.org/r/20260415160006.2275325-3-jacqwong@google.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis_core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -556,11 +556,16 @@ static int tpm_tis_send_main(struct tpm_
 			break;
 		else if (rc != -EAGAIN && rc != -EIO)
 			/* Data transfer failed, not recoverable */
-			return rc;
+			goto out_err;
 
 		usleep_range(priv->timeout_min, priv->timeout_max);
 	}
 
+	if (rc == -EAGAIN || rc == -EIO) {
+		dev_err(&chip->dev, "Exhausted %d tpm_tis_send_data retries\n", TPM_RETRY);
+		goto out_err;
+	}
+
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
 	if (rc < 0)



