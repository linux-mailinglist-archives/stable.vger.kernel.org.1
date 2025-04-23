Return-Path: <stable+bounces-135233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAF9A97E64
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A5A7A58D6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 05:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF03265619;
	Wed, 23 Apr 2025 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vus3iEYJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00963EAFA
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387674; cv=none; b=hgefhKAr2mGw9nl41cS+RjUxfAIEyEYMWpTF39iIc/3QO8eHboEwM49ky1+iti6vnL+EAIT3Q+VTebqGZUUXVf7kNMTyJj8zi3BFIZX7CfI5KwhV7Q9URwZ8whPrX0UdaqRWT/wPVEGqfc22RVzXgC4n23DS2FjUBtrqYjfDAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387674; c=relaxed/simple;
	bh=MfsszCuTzfKJNB4tBqQ9XmjAcHPDxzKoZFCnjwAR1N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtxVK3WVhZEKJpd6DhwMWhhvMbd+jbVFKTPuCizQMKxv/dCPPOJVmGbF5JWoUA5UblqiBlUdJfjS26Z/pEDwDqLRFtU3gw2VuQLR/gXw/uZV32KzaY7mEHBypJ2KRc58a7xxljG3fvTTkRVaTebbUXMcx3UgKuXw1r6rMTHUo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vus3iEYJ; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-acb615228a4so99826866b.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745387670; x=1745992470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQP1l63BXuz9UDm1ciSAt2cMP3KXQbP8eVDhs/pQcbI=;
        b=Vus3iEYJUPfXfEmT3Mb5biJ4xRh2S44Mp5Okglpj+FiIIfR06ke/h4uZMumSf/Dph3
         oZ2GHsCOGHWlz2NHHQrJquO638N+vmjUvy+6mYui52StYkEL3or/KQ6ijB2zXWPVBHMq
         9+IGDUDfOI3ZhzHsBY4KBJ7CKCj654LSRoLtKZfDyhiKW0N596D3x2TeRcKYnFLt0yrN
         y7Zr+WZX6SJGctX73f1E3+17k/RGCye0PH9X7hR0FvAoRiHIqYog4jy0M0aSb/RB6vaU
         fAQNr2c73L3fdSBgNJd9mJzValeTsH7nUDbUhSgP+Mt28XZCxd9IL2+O0mj35rgq01M/
         bnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745387670; x=1745992470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQP1l63BXuz9UDm1ciSAt2cMP3KXQbP8eVDhs/pQcbI=;
        b=G6FIP50kgbXRBAIY2FZzlniJt0DlPNjshf4Ptezl1jgD2VoyFEHRnyVHmc3eRsFaFV
         Cckep3W0fxvL7fsp7YCqsaEV9y10VMzE4PglLnZHehBaxWoq+Tw0VEdzzHKYiHbJkfot
         wAi5Oo7IKsfL8Iqb3Mi3doXoNJuXh0Xq2WYx1HEDSR2Efv4u/jBE0DuAwlhWA7Vqip7w
         vHxfyg5foXsvDQjqF4XCxTlgKqVjF7RcnzGs2ePDz9QQVUoJbKdGOWGlfhj/CM9/VFmS
         UN/lp/9UYUUdm2/TwbONRDyCnehVpZi/FD3yP4XOp4y6UYRpLPs9C5w8EJOwKoaBajhF
         M6KA==
X-Gm-Message-State: AOJu0Yz2YkLLSonT0XKp+WY3z1oLidx4r0dvrf/AMrxFUa96onf9DMh4
	D76LokqPxTwOV6XiNuBbvhSTyZxax/vCb2Txcbh08IS1ARNZgJrn6wONBUNrbEBQbH6u6itwOIQ
	M9VXBuw==
X-Gm-Gg: ASbGncudDkoqLBZOR/wtSvM8LX07UbqNgD4tLudBU4l09/B2XOR9Nsx5/3Jy1d74hkH
	2wIkNpWPoOItoEu3unUEBal7E1kxFo4fkfvayDjgk2zOynd5+0B5fDsIv4G8tV11IViE77NV5Wc
	gwznsMU6wTZVI4wrWsvv4b3Ygo7+ozBr/yTnw0WkvvSmvI033isf8fkQYX+kPjTk0cb9BKkH2/Z
	TZKVMxSIYU2DF94lyc416F6EPnj7kW30p6PyPYV3suHzb4A8BLKU/ctpbqaaue89HhAWhQVj+Xu
	NBobf8EIwMg2VKuYZ/vz50sPDSiPjDd6uMBzvoONu9KberlZJ9TkoJoQoYGctjIRpbXnzpGAkOS
	t1gFa
X-Google-Smtp-Source: AGHT+IEgPZDWHTaJ20lb4nCsOwgCY479ZkIbij+C519oncRyKHaPMjD0o/jg8jG9NYJCC5MbXBspPQ==
X-Received: by 2002:a17:907:3e10:b0:ac6:e29b:8503 with SMTP id a640c23a62f3a-ace3f255374mr119851766b.1.1745387670110;
        Tue, 22 Apr 2025 22:54:30 -0700 (PDT)
Received: from localhost (27-240-233-37.adsl.fetnet.net. [27.240.233.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-309dfa5e8b8sm784445a91.37.2025.04.22.22.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 22:54:29 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH stable 6.12 7/8] bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs
Date: Wed, 23 Apr 2025 13:53:28 +0800
Message-ID: <20250423055334.52791-8-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423055334.52791-1-shung-hsi.yu@suse.com>
References: <20250423055334.52791-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

commit ac6542ad92759cda383ad62b4e4cbfc28136abc1 upstream.

bpf_prog_aux->func field might be NULL if program does not have
subprograms except for main sub-program. The fixed commit does
bpf_prog_aux->func access unconditionally, which might lead to null
pointer dereference.

The bug could be triggered by replacing the following BPF program:

    SEC("tc")
    int main_changes(struct __sk_buff *sk)
    {
        bpf_skb_pull_data(sk, 0);
        return 0;
    }

With the following BPF program:

    SEC("freplace")
    long changes_pkt_data(struct __sk_buff *sk)
    {
        return bpf_skb_pull_data(sk, 0);
    }

bpf_prog_aux instance itself represents the main sub-program,
use this property to fix the bug.

Fixes: 81f6d0530ba0 ("bpf: check changes_pkt_data property for extension programs")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202412111822.qGw6tOyB-lkp@intel.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241212070711.427443-1-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2e16349ae3f..d2ef289993f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21990,6 +21990,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	}
 	if (tgt_prog) {
 		struct bpf_prog_aux *aux = tgt_prog->aux;
+		bool tgt_changes_pkt_data;
 
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
@@ -22024,8 +22025,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension programs should be JITed\n");
 				return -EINVAL;
 			}
-			if (prog->aux->changes_pkt_data &&
-			    !aux->func[subprog]->aux->changes_pkt_data) {
+			tgt_changes_pkt_data = aux->func
+					       ? aux->func[subprog]->aux->changes_pkt_data
+					       : aux->changes_pkt_data;
+			if (prog->aux->changes_pkt_data && !tgt_changes_pkt_data) {
 				bpf_log(log,
 					"Extension program changes packet data, while original does not\n");
 				return -EINVAL;
-- 
2.49.0


