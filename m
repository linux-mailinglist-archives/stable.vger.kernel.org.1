Return-Path: <stable+bounces-26679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9F9871003
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 23:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100DE1C21B0A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939287BAE1;
	Mon,  4 Mar 2024 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2MAQ/r9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166121C687
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590815; cv=none; b=a9vXIOvD6zhLfmVmWAmB3WPfzaXMwRDXgPGJQqFwKrjW2+U06GBnG9iyK20ZAhKzMS3v4RZqatpR9yxnBBvGMpYgG+7XvskvWWz+dLSsANW7RQG7ODB9ejGMfG1l5h7XrWhhDVmyHi1lKiqK47gwlHo+FKVOUiMYY0u8NNtHO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590815; c=relaxed/simple;
	bh=daJJ+O48/rxQfVLn4qSUO5TBMPB93fpJojNV87v3Jho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bOgAAI51snkT9IUg8v6j2zcs6QlWt+pFMs1XOZiWnr6ZWKl6rYRqbZAJ/t/kMV3LD32M+s9P2m9Z/wo8ruIQK+y2F2ULc3PkAUL+m3O3aO8rK8rgV941Cx+izPgkAhH9jQ01vuhlrbwHoGCvTdS41e/wovpOHoDONxif30O8V60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rnv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2MAQ/r9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rnv.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4a072ce28so4604755a12.0
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590813; x=1710195613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=daJJ+O48/rxQfVLn4qSUO5TBMPB93fpJojNV87v3Jho=;
        b=j2MAQ/r9iVHjX7PLGobpkdi1hAyPRwnb1yboJGvjiQTjl3V7i+U3AT0q3l6mGMPG57
         h+endH8C+jOsudeVij4YiyUk10pg4sUmJTnQEQTh9rUCG/xUwfNOdsiQJeyDy++SD/P+
         HyHb3jQd1fqxT2YMGnlHY59t0bOIe9hLBYiU2RDfWpi8Uw6fCq6Sm7CD8E9c98DGMhYW
         zIJSGUZ9aiYlxcErsEog2XfOd6noAYIa2VHfhk5t7RYZiGCcE0to6gOVYJBihByfLjXJ
         5m8qKmFA1S6M4miF2up4Fyn+xzlUH0JD6fZfSShFm3B4J41odAQ/fxnugDM6+sR9L+No
         tICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590813; x=1710195613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daJJ+O48/rxQfVLn4qSUO5TBMPB93fpJojNV87v3Jho=;
        b=QjeIrbbhmOShj/ronxwH8hqWd54CZR0OjAJzjr0WM/yQgA5QcIOV4xsWfIjLlMCKRP
         B5mYFFV0rjTvzg1iS+8ALZ5WohZ1MN3f5Frb8WSlYSJTtd6TCL+hluNv1Z5B2weUF11B
         a4zOe626ssX/saMgDLJ9XFaxSuno8Fy0atqsZMU35/LUzimYujtVx0ManeIiZTyK0EMz
         70I7j0v3C1nMEvYUHToWp/G/9hGhMra2RnYjsv2QPJEDZp39J/DEaOkhXkWvxGtGZuhf
         EtHkBSQckVxmJOLC38WAcNg8S06T9lb02hIDHPQlu0oCvYS8/uSzejtdPtPZPwKTKaMp
         wF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXichZ88g6/oUg5dQ0P+uo6AUioSn3sdtO7VAPT8XUL1T5BGb+rhnFVQKpuyLk5yXMHjViLuGpeVVn6qj7WPOzPL3f8Tr66
X-Gm-Message-State: AOJu0YzDOz+d2kv1GAdO4bHr4pnj3QUv/wXakQ5PYVT42FD/KWwQNXRj
	/8BP7nBsWR5Eqtv2h4rbdM0ss3wtnTOMIWy3V+zlv5g9osVpFB2U9xNBjsd6TTXLQA==
X-Google-Smtp-Source: AGHT+IH6n8nD/pd+GpoBbvd5C2DsH5JzWW5H+GIS5zXoOxKlXMSHiTDp7/imzsPzBowYnQHpwLonIuE=
X-Received: from cos-rnv.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:81d])
 (user=rnv job=sendgmr) by 2002:a05:6a02:f87:b0:5e4:292b:d0eb with SMTP id
 dq7-20020a056a020f8700b005e4292bd0ebmr25591pgb.2.1709590813310; Mon, 04 Mar
 2024 14:20:13 -0800 (PST)
Date: Mon,  4 Mar 2024 22:20:11 +0000
In-Reply-To: <20240203035346.771599322@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203035346.771599322@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304222011.2221862-1-rnv@google.com>
Subject: [PATCH 6.1 214/219] mm, kmsan: fix infinite recursion due to RCU
 critical section
From: Arnav Kansal <rnv@google.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	dvyukov@google.com, elver@google.com, glider@google.com, hpa@zytor.com, 
	mingo@redhat.com, patches@lists.linux.dev, quic_charante@quicinc.com, 
	stable@vger.kernel.org, syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Are there any plans to backport this to 5.15, or 5.10?

The buggy commit (commit id: 5ec8e8ea8b77 "mm/sparsemem: fix race in
accessing memory_section->usage") this commit fixes was backported to
5.10 and 5.15 and wondering if there are any plans of backporting the
fix to 5.10, or 5.15?

