Return-Path: <stable+bounces-114850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73739A304D6
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6E63A8024
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 07:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503FF1EE019;
	Tue, 11 Feb 2025 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHcR0VR2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E31D7E57
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260109; cv=none; b=qQwSkVB6odIzFPnJ8hSqBKGxK9cVIA+lPkW+MdTC60t3GQyUT7gno0met0q0NtMybBNwKcVXgrGOlXXSUgHnwYHswqd9dXC3x84HRL2+yfdrL6gyxVS38JbpEAlT4lqdk2i8k3RpmZOktkDR4BQypT8fEFhxLGGBboJeWGJIchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260109; c=relaxed/simple;
	bh=ti7SQMSGkZmBsu1MPhxB4Tlzh7MdbHJL2VwMogA5Doo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMahhtyIV0Z1IKJbHFroUJXNbjUdzjchbIxpdqdE53Rzgp7dQ2sxqrrOuTtbBLEMDbxM1zei0AlGdkA/+TtaAu9/5/gqQ7kD3YL7JYh1XThyBrJW+TKq8g0oLbDd9lyEy/7YhjeoC9Q+J6BSal+F+QPPa+T+CJBTruCk/NtL8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHcR0VR2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so7451153a12.3
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 23:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739260105; x=1739864905; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Lco/NiUiU4FOOJ/aVWa7MAjUSliO26a1kIkwUe28IU=;
        b=FHcR0VR2s87h79MR48MO8oTkQhS4xLTC5FnHrwqdH+TcESfXFhciQBFhbuP3Ilby31
         1Z8YXrdmc//TmNuEGNL2bTUQQS1N0VgMjHc6/a8OSmRwlOowKjKQNXLk0DwO9XhHrXFL
         tSV2cI5VBD/wGxZ8hDxfjI8oYY8p5sOD4U4LtNqNFLDWr2cyTPRWhVjpIVRsJ+uvjzqy
         GEZyzgyiSYcz2+g+7K4BafYETOR74mOcpquBlF3X1Phr79rkxsfeWNlfvZn6zmjj+iFU
         TQeD1sMjbWeFMaSxx0Cun6tzfGbqLk1EoCiyXcyvXjZBjp41RKHEZiXQOSxTWjCK0DW3
         /Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739260105; x=1739864905;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Lco/NiUiU4FOOJ/aVWa7MAjUSliO26a1kIkwUe28IU=;
        b=OaSX5JllxuXLvyhGdiYHUspEXxmQWpiKV2wOL0iOed7Svt3QKhQGKAqBYTUG2rofQd
         9O6oOLV6QpkGwxr1eVVuFOsAT5wym1om/Klj1s0gaSLp0Eab1snP5BJBBnv8fJrEFR9L
         p+3HpxnjqARIgOSx95audwIkTg6ZjE5IpqQv6MX1yvo3JP/CId/ot6IfLFcXXfT1mEMI
         Li25l7We4JwuLojdq/8ZfoKDRAywZvsCGXt9a5P4K2ttCGcNHAQ0WkG48j8NpXXEwmP6
         tsg8as3CwUythv9rxPgc/5lxPeWiejZ7/Q4KPeFVottO579SJftgl1ginvDu/jXcfGK4
         ZE/w==
X-Forwarded-Encrypted: i=1; AJvYcCU9Vz2/KW8Gjp6llTSEOam+yH7MWtw328PVrHhv5NrahZMhX5RsIya1AG2SQMGDTfeTBN+2rKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykedg7jZ70mb3uMKT4gthQRPnf2SMU5OMHv1BDFFPjsW3dZveM
	kztuPdy3acOpP1tuchi7Outdq0aTb2X+/gN7xtjzcPKP6j0/KcTL
X-Gm-Gg: ASbGncs43Zl631lsa5LdOE7qHSlG7I5pqUkRbir/8aeIebqdtKLbXoqgidlBFJ9eAQg
	ZO9XnKwmTMj4BDfCE0m0nf/mar1vh4CRESZT7vMvsQq5FoTXAtZMQV0R+Kj7PP8YtZz6NNu01TK
	gnG3OvGKSo0pze5/F4CB6rfw7KyEXQtHIvabyZqCTWZPkj9B+TP1eY7rTBlKb3ayfEs7+JhnkhH
	HrQK4l7n6FDBdKf+Dl824khgN/IwaV59sEgiR2uznn8+D6nmq0wlB03Q2JGuW0P55hrlg4qPYrZ
	wuX7tJCHkSTDLr8=
X-Google-Smtp-Source: AGHT+IFSA8kWoH4jOKBbAt4r5rTe1V2Nv0LS3cE4VqImV5sRNitQvfeFRSmzdfin6q2KuMw8ZMEahg==
X-Received: by 2002:a05:6402:358f:b0:5dc:7f72:5eae with SMTP id 4fb4d7f45d1cf-5de4508dc87mr15326343a12.23.1739260105319;
        Mon, 10 Feb 2025 23:48:25 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5e6ac118sm6089594a12.17.2025.02.10.23.48.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2025 23:48:23 -0800 (PST)
Date: Tue, 11 Feb 2025 07:48:21 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] maple_tree: may miss to set node dead on destroy
Message-ID: <20250211074821.uw43qk5mk2shrndk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250208011852.31434-1-richard.weiyang@gmail.com>
 <20250208011852.31434-2-richard.weiyang@gmail.com>
 <42meyihs3gnp3bbvn5o76tzh6h2txwquqdfur5yfpfu36gapha@rtb73qgdvfag>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42meyihs3gnp3bbvn5o76tzh6h2txwquqdfur5yfpfu36gapha@rtb73qgdvfag>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Feb 10, 2025 at 09:19:46AM -0500, Liam R. Howlett wrote:
>* Wei Yang <richard.weiyang@gmail.com> [250207 20:26]:
>> On destroy, we should set each node dead. But current code miss this
>> when the maple tree has only the root node.
>> 
>> The reason is mt_destroy_walk() leverage mte_destroy_descend() to set
>> node dead, but this is skipped since the only root node is a leaf.
>> 
>> This patch fixes this by setting the root dead before mt_destroy_walk().
>> 
>> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  lib/maple_tree.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 198c14dd3377..d31f0a2858f7 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -5347,6 +5347,8 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
>>  {
>>  	struct maple_node *node = mte_to_node(enode);
>>  
>> +	mte_set_node_dead(enode);
>> +
>
>This belongs in mt_destroy_walk().

You prefer a change like this?

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e64ffa5b9970..79f8632c61a3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5288,6 +5288,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 	struct maple_enode *start;
 
 	if (mte_is_leaf(enode)) {
+		mte_set_node_dead(enode);
 		node->type = mte_node_type(enode);
 		goto free_leaf;
 	}
>
>>  	if (mt_in_rcu(mt)) {
>>  		mt_destroy_walk(enode, mt, false);
>>  		call_rcu(&node->rcu, mt_free_walk);
>> -- 
>> 2.34.1
>> 

-- 
Wei Yang
Help you, Help me

