Return-Path: <stable+bounces-212896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABSdCFrwfGndPQIAu9opvQ
	(envelope-from <stable+bounces-212896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 18:54:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B246EBD854
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 18:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B33303D722
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 17:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DAD36655D;
	Fri, 30 Jan 2026 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="lvqXB7nL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E834E767
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795633; cv=pass; b=R5KBkXT+boccuxKyu1ggniC5HC5EsO3CV5JB4yxfLfdTGbFb3GFFytyyGaDrn2l6y7ok3jIjcHqYpcFNQiSQ1LFehOHpp42FlZ2tuEwa1ckUynWAzc6tYc2QNkTztabvX4+kbMMqKppy1j0mZb3CNmWjV8UYcwXdHo4DctYcaSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795633; c=relaxed/simple;
	bh=326he210/tRZUiUmp5+sWT8etWqVRtLzZLG9pPxkOqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FavnL6jPohtO1w1uRbjcZ45H1ZfgnzMfnydMGATfjsPACLFIe/PQdHvM8N/Ob/bBQ7sEQn3KvXr66VQIkduVV12ywvpmhI7XBx9zoBFgc61cGdZoOQI8zaWbSsiE94Lq5gkqY+x/Wv8FkgfGzDtYFXLraKZPSmwsCTA4o/qedEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=lvqXB7nL; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8230c33f477so1087855b3a.2
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 09:53:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769795631; cv=none;
        d=google.com; s=arc-20240605;
        b=gnaM6XIGrA8KNasPLsQjJoQ+3KlznelwySQI5K1i7kD2gyHsfdeA2CvQmjd5V0LTtf
         r0v43qMEOp9Kih/qeSeB3oWCaZj/ES2rTSqBr9A3LJ8Mh62umgczB/sOBwukUPAt5fmq
         pWCl5Hp1Rosv0/CdlyEHT2DpzoyqkZ7J6aIOFdpdxXNbkGkiunxvemUfsbTCNFBl8sbu
         ZbgWhZIkSHKpf5BQe9OtmFfdR6AluNpFXcHMljYhVjEim14HKeuD2G0H5vOXY5aslS8v
         aZfa/eRslsig93al8kHTgJyNfXe7dswWhr3CSh0ejsZAkkRDbEK6k97fClXQHUS1F950
         dffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2vQAO1Uv8zYyW2LQO1EawZkOK3KNj111fQmdKtqn2pc=;
        fh=duuI4EYlazk9snXQFv1EeNm7GyEp056/pZL41fcp7fc=;
        b=WHJh7ZToEjTXwC0V1y+vkkpqYELu/TMHtZvQDps+9JJmaZhwpdvS+k4cPpqKKBjpOf
         CZUb8IsnGfEOYdyxtw7K52a5AGd0IM72a66vYbcfT/e1lhTS5HLiMeQFUiFA80nj1lzw
         44Wn55Rim5ZcAYp+kTlzli9+4+QlMtYJ+Xvc8YvjWXXuv2+OpFfcNIH0ZWkzKA5ukcKw
         A9CIrVN8xvFAvKqFFnp47k7+3vQvJaDPHQbp1ZLWchLIfLgc9+rbZsn5CWTTMpBJUOq+
         18W/2Ylr4Bv1CT4sNgi+Cdyuw/jo+HFnNoMvRQsWLi8XjzUDZocDTwNq8oTSmH3lQGrl
         wCyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769795631; x=1770400431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vQAO1Uv8zYyW2LQO1EawZkOK3KNj111fQmdKtqn2pc=;
        b=lvqXB7nLsiR+cO4h+FLw1npQHKOEDqLC85zIfdXSWxy6Ae9x8QnfmhSBuEyAkhphHW
         JW7eE/AMSZZ1Ub80WcnCPonHfvlsNi2wg5/vuOD893X/twFxOroJvFxARweAcTfGUQtk
         HqE/PupgfPkxIOvLl0KWHyApCP6SaKrla9qhnxzTBDzSjHbnkwYBKnYXNGnZHGmaYpfI
         J2Yds9tsH+4ZrLOKzapjjJfTdEPAJoA6rKuJ9vqu6l4XWY2rWGQERDs9SP6StOzowJRD
         7FjQYz4wgFNnlH3pkHKYdAPp2tX1ioW/lqrVg6oTCdX/vn/keQBnWLixi9qaPawJn7Xu
         LJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769795631; x=1770400431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2vQAO1Uv8zYyW2LQO1EawZkOK3KNj111fQmdKtqn2pc=;
        b=TdIRdUx8QccYTnOD8ENtGSPumB8yzDw/+Wl8sEbWieDjmZxe9+pzaqtahf4RQCc2KA
         RGpGIdlySrERoYDdgCdcmv+U71XYazMSQ8t9p1DZLjuPndK23zR4isU88Q2gHZkKB7W3
         spzUEX28h+UgzXSSoKVS4I16T5xgx8EM4MdRbOlJCf0AFPQNeFtaD3I4Wzvnl9BoiXf4
         s6LqVPxDPv3Y6P13sF019/bSTHnsVX6h8Mg6kKo6RVrqy5iNLGCJxVE3uu1DC/eMgm5R
         6AwVAeS+PdPAJxFRrLeEteicETsG0pNLo4bwNME2noXhzWkmIZXkh8nPak3nlsQ3XXKB
         lPJw==
X-Forwarded-Encrypted: i=1; AJvYcCX22IB8hWldUPQpXjjwfPMsxOHhfX6GXUTIhFljfvGynPSB5lETH79niW9QM6TFnOW1uf8g47E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEoZyU1iPh1HRdv7umu0k60WMyU51QRgLoO8WMLvVflszKGTd
	wxP0oLaTMVqCIk7veVJlSk9aYrNBltzDULhQn8TnvbrUhpZd9mRSf2sdDFGP7BFX5yZF/5pmdug
	rM0KCu2Blay7lCdWF7IGjlSz0qZkZWA3v/+ntceXp
X-Gm-Gg: AZuq6aIBJmUWk2fFUNGkwTn2UerMa69qHTMaIt2Ie+J5j73p+XBoKCZr0sqet8P4nl6
	nfvP8l7/ARAuDbqSIUE5XQbPOtdvbwYmeEoxZ3HeTGi2bG0DazFR9CnUnLgLvnpWjEv15ExBwih
	+rj/JDtHNDoqAOLnwgbsSXZBNyY/vYs3SF/0PnxFB/E+4933pc2XT1lUgF3sa+aIdXQfyfFkuCn
	2rCBiJreF1Gkt2Dgd6yj+V1dqGe7vRcEHdZKIseMOMkoo5AZ+3OtGicUGohigll2w82+9yH1dMt
	sz52S1qO8gG9vg==
X-Received: by 2002:a05:6300:6141:b0:38e:91a7:6352 with SMTP id
 adf61e73a8af0-392e0163b8dmr3106804637.66.1769795631321; Fri, 30 Jan 2026
 09:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
 <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org>
In-Reply-To: <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 30 Jan 2026 12:53:40 -0500
X-Gm-Features: AZwV_QiQhjrnk_kiCNTQ9hpPibGH8uv5bn2JIzi1spPEoRMYIYMFhv-zfwvpGj0
Message-ID: <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212896-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[raw.githubusercontent.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,1g4.org:email]
X-Rspamd-Queue-Id: B246EBD854
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:22=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> Yes, In net/sched/act_api.c the GETACTION notify path always does alloc_s=
kb(NLMSG_GOODSIZE), if tca_get_fill()
> runs out of tailroom it returns -1 and tcf_get_notify() maps that to -EIN=
VAL. So failures are size-dependent
> and can look intermittent across different action dumps. act_gate might b=
e the outlier?
>

Very bizarre that dump would fail because it is transactional. It
shouldnt matter that you are only allocing NLMSG_GOODSIZE.
Is there a possibility that  a single act_gate entry can be larger
than NLMSG_GOODSIZE?

> The size is already computed in tca_action_gd() (sum tcf_action_fill_size=
() then tcf_action_full_attrs_size())
> and add/del already allocate max(attr_size, NLMSG_GOODSIZE). This patch j=
ust makes GETACTION consistent with
> that.
>

I looked at act_gate dump and it is sane. Which leads to perhaps your
test program being bugy.

Install the 100 actions then use tc to count.
Something like:
 tc actions ls action gate | grep index | wc -l

cheers,
jamal

> On the reproducer: the gatebench test with 100 entries is reasonable.
> https://raw.githubusercontent.com/jopamo/gatebench/refs/heads/main/src/se=
lftests/test_large_dump.c
>
> I plan to follow this up with another patch for act_gate and believe they=
 both are integral to fully stabilize
> act_gate.
>
> Thanks
> Paul

