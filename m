Return-Path: <stable+bounces-245202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMyQHk7WAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:14:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E373650EAAE
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 557103082435
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE20A3DCDBD;
	Mon, 11 May 2026 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="aACRmgdB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64D372EF0
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505071; cv=none; b=VAFjhoFkhtlFGUCvFf12cqM/OVcloMkqysthtU6GqXoiyZws33TcSCzq3hxFUBHiF39DV+ijA0uy5GKth5rdABzF+MSduih32m+xOpwfwFGtbOd2tcsXNG9V0iRKuTTUe6frdhh7ueCdx+lRAE2GPf6U6qvgjId5i0mpILHCEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505071; c=relaxed/simple;
	bh=GJDw0Vr/GXAJ9CXhMxW/CsDAlu40dEkdLD89v1rzEAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjPKoHe2b0TrsUPtX0ovyYqHHmWlmY4yGyRDgXFLWsNfa+ylCM/2qR0IqOCmxbpdG5fuvg4dN3HDCEW9atX2360rDpL6dSxoYyHGzobnUKTeSm4AIBVdc2HXntEKYERI+cShCPhpxWe6u3je0gecai0vmnvjB5peYOnIYBrkOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=aACRmgdB; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4824176bbbeso837968b6e.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778505069; x=1779109869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krd1iEfXknLd7NaueCbxakH3PI/lvcnloEK4wgXwWPU=;
        b=aACRmgdBsOFrnrOxT7DkvaUnog8AtdnA+VUwvtj8Z+dwhB+WRaAIz0X9Y6s3L7XXUK
         e3qviX7Cu8FOw4n75FjeipU4x8/Xbj35RKIVCKhgUpDuJzXmKYry3AWYH7dYvx0oP/Jk
         /6HD697hQmUJ6xrFAX/2gHW+5s4EEHrOHnes+7GV61SIIyZc7/nYdrSB5e63/Y6ieKDD
         AsBnsiVWxlm+SCVpVbfEuDdDuGbhmnDVcEB2b5u4DlDzRySCMtrEHVAkTcQtY5CYQl5A
         WdqnLeJn+Waw+gk+XRf4vAtNd6+78iWlkDi1+rIuRTOTzYVJcahpnuwTHfubG2BMzH/V
         5VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505069; x=1779109869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krd1iEfXknLd7NaueCbxakH3PI/lvcnloEK4wgXwWPU=;
        b=lo3V+Lrll7eDvqls9qRMNGancZD+wRcEXCgA4ofiIYR0nvFNlGdDUc+Yk9HRlP+p0u
         bWbrgeWOk31Db8hi4ziNCGYbesICA27RhvDTbIhFC4hylK7GIT+/DlmdhBYZ+D+PwN4e
         KPGDuM0zCR/PrhOGIsjQLURSTzRF3/bz+54nTk1QRIai9/8BCP1xuoC/5hcSdEajAKqH
         Uj+j9FluIecjDUd3CBMub2F5E8e4MSNgAFvThEs7C/NAIgJ5CL1J8rIdB4X6LssafOHW
         ZbFT5mWh05vGDqsHusp1d0sEy9I1GH62W4xLI5yBEHye0ZgciGXO+brWCi9ZUdNw10Qk
         5T1w==
X-Forwarded-Encrypted: i=1; AFNElJ/3xn8711ONrdghKNGfpHMddOlnBlwCxwJuq/KIwO67iAwnwVDszvzmZpolfWYw3Im/FxcukRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRlVe5jhCVp+4wTbs8GuzeDtNN+QeykMhyuOiHrvTTQ/58vOm
	HylvVdMSNgKFcTFOeUFlJeAEFXhSqqnDcnJPYfmhyXD3yw5p4lT9bNXWeiXByc3Wgeg=
X-Gm-Gg: Acq92OHeZU3M7lMqrQr/1DDh/bG1GMAi+yU2sbjPWCVlP1ueFgMWnJw7V7xIePg9O0b
	q1LqLyUyHRJmhS88wHKOLQyZ4VzHftwnSx7MNHYXT3uAYY+WNVIjtH0aL7H1Golg8gUBXYEOWiq
	b3Bij2ZbLMO11RPrxh8oz9bPIbR5J4ZX2Gp0wzeXD/rpBK3p1C56feANAyqSpPd/JwkiiQjunxW
	stwc4PoABNJPxCdscvnhvPakm97/G6pFPdFZO340nb8gh5JuRDZxdAPjnKn5kMz3VQl1UPHE/ln
	vG47qiXa8avaN1Ik72OGEj9lso6oUHLL6tgT/9rv8+nLagYK9O54/Jgkr+FDnvsTX8jIZobfJDS
	q6rVoYuG51bobq6kcLGbEp5imLH/8N4AhMp62Tda6abQWJBiw2FLhQjYFt05PFfFioMlwSi+F/t
	nNbJh/fL7hJUwhiZhVzwKZ2iqZIeaxpD2eBKM1j4dyCQHEtI+Ymyi0kFKaYRjuCLMi4arLFbJzt
	91DZomCtKbd0g==
X-Received: by 2002:a05:6808:5090:b0:468:6a2:897 with SMTP id 5614622812f47-480420d6d2dmr15961166b6e.6.1778505068939;
        Mon, 11 May 2026 06:11:08 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-47c76936271sm20146745b6e.9.2026.05.11.06.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:11:07 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Li Xiao <252270051@hdu.edu.cn>,
	Corey Minyard <corey@minyard.net>,
	Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 5.15.y v3 1/4] ipmi:ssif: Fix a shutdown race
Date: Mon, 11 May 2026 08:09:23 -0500
Message-ID: <20260511131100.1772190-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511131100.1772190-1-corey@minyard.net>
References: <20260509122858.ae87f8133ecd.re-ipmi-ssif-cleanup-5.15@kernel.org>
 <20260511131100.1772190-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E373650EAAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245202-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,minyard.net:mid,minyard.net:dkim]
X-Rspamd-Action: no action

It was possible for the SSIF thread to stop and quit before the
kthread_stop() call because ssif->stopping was set before the
stop.  So only exit the SSIF thread is kthread_should_stop()
returns true.

In the mainstream kernel this was fixed in 6bd0eb6d759b ("ipmi:ssif:
Fix a shutdown race").  However, that requires a fix in kernel
version 6.1 has a fix to kthread stop to cause interruptible waits
to return -ERESTARTSYS on a stop.  This has not been backported to
older kernels, and that would probably be a bad idea.  But it means
that the mainstrem kernel fix for this will not work.

Instead, wait for kthread_should_stop() to return true before exiting
the thread.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 30f757249c5c..430302d2da6e 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -513,6 +513,16 @@ static int ipmi_ssif_thread(void *data)
 		}
 	}
 
+	/*
+	 * The thread can break out of the loop if stopping is set,
+	 * and this can be before kthread_stop() gets called and thus
+	 * kthread_should_stop() will not be set.  This can cause
+	 * spinning calling this function and other bad things.  So
+	 * wait for kthread_should_stop() to be set.
+	 */
+	while (!kthread_should_stop())
+		msleep_interruptible(1);
+
 	return 0;
 }
 
-- 
2.43.0


